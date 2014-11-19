package Postcodify::Query;

use utf8;
use Moo;
use Types::Standard qw/Str Bool ArrayRef/;

use Postcodify::Area;

has sido      => ( is => 'rw', isa => Str );
has sigugun   => ( is => 'rw', isa => Str );
has ilbangu   => ( is => 'rw', isa => Str );
has eupmyeon  => ( is => 'rw', isa => Str );
has dongri    => ( is => 'rw', isa => Str );
has road      => ( is => 'rw', isa => Str );
has pobox     => ( is => 'rw', isa => Str );
has numbers   => ( is => 'rw', isa => ArrayRef, default => sub { [] } );
has buildings => ( is => 'rw', isa => ArrayRef, default => sub { [] } );
has use_area => ( is => 'rw', isa => Bool, default => 0 );
has lang     => ( is => 'rw', isa => Str,  default => 'KO' );
has sort     => ( is => 'rw', isa => Str,  default => 'JUSO' );

sub parse {
    my ( $self, $keyword ) = @_;

    my $origin = $keyword;
    $keyword =~ s/^\s+|\s+$//g;    # trim

    ## 검색어에서 불필요한 문자를 제거한다.
    $keyword =~ s/[\.,\(\|\)]/ /g;
    $keyword =~ s/[^\s\wㄱ-ㅎ가-힣\-\@]//g;

    ## 지번을 00번지 0호로 쓴 경우 검색 가능한 형태로 변환한다.
    $keyword =~ s{([0-9]+)번지\s?([0-9]+)호}{$1-$2};

    ## 행정동, 도로명 등의 숫자 앞에 공백에 있는 경우 붙여쓴다.
    $keyword =~ s{
                \s
                (?:
                    ([가-힣]{1,3})
                    \s+
                    ([0-9]{1,2}[동리가])
                |([가-힣]+)
                    \s+
                    ([동서남북]?[0-9]+번?[가나다라마바사아자차카타파하동서남북안]?[로길])
                )
             }{$1$2$3$4}gx;

    ## 영문 도로명주소 또는 지번주소인지 확인한다.
    if ( $keyword
        =~ m/^(?:b|san|jiha)?(?:\s*|-)([0-9]+)?(?:-([0-9]+))?\s*(\w+(ro|gil|dong|ri))/
        )
    {
        my $addr_en   = lc $3;
        my $addr_type = lc $4;
        if ( $addr_type =~ m/^(ro|gil)$/ ) {
            $self->road($addr_en);
        }
        else {
            $self->dongri($addr_en);
            $self->sort('JIBEON');
        }

        push @{ $self->numbers }, $1 if $1;
        push @{ $self->numbers }, $2 if $2;
        $self->lang('EN');
        return $self;
    }

    ## 영문 사서함 주소인지 확인한다.
    if ( $keyword =~ m/p\s*o\s*box\s*#?\\s*([0-9]+)(?:-([0-9]+))?/ ) {
        $self->pobox('사서함');
        push @{ $self->numbers }, $1 if $1;
        push @{ $self->numbers }, $2 if defined $2;
        $self->lang('EN');
        $self->sort('POBOX');
        return $self;
    }

    # 검색어를 단어별로 분리한다.
    my @keywords = split /\s+/, $keyword;
    for ( my $i = 0; $i < @keywords; $i++ ) {
        my $keyword = $keywords[$i];
        ## 키워드가 "산", "지하", 한글 1글자인 경우 건너뛴다.
        next if length $keyword < 2;
        next if $keyword eq '지하';

        ## 첫 번째 구성요소가 시도인지 확인한다.
        if ( $i == 0 ) {
            if ( my $sido = $Postcodify::Area::SIDO{$keyword} ) {
                $self->sido($sido);
                $self->use_area(1);
                next;
            }
        }

        ## 이미 건물명이 나온 경우 건물명만 계속 검색한다.
        if ( @{ $self->buildings } ) {
            $keyword
                =~ s/(?:[0-9a-z-]+|^[가나다라마바사])[동층호]?$//g;
            if ( $keyword ne '' && !grep { $_ eq $keyword }
                @{ $self->buildings } )
            {
                push @{ $self->buildings },
                    $keyword =~ s/(?:아파트|a(?:pt)?|\@)$//r;
                next;
            }
            else {
                last;
            }
        }

        ## 시군구읍면을 확인한다.
        if ( my ($sigugun) = $keyword =~ m/.*([시군구읍면])$/ ) {
            if ( $sigugun eq '읍' or $sigugun eq '면' ) {
                if (  !$self->sigugun
                    && $keyword =~ m/^(.+)군([읍면])$/
                    && grep {/^$1군$/} @Postcodify::Area::SIGUGUN )
                {
                    $self->sigugun("$1군");
                    $self->eupmyeon("$1$2");
                }
                elsif ( $self->sigugun && $keyword =~ /^읍|면$/ ) {
                    $self->eupmyeon( $self->sigugun =~ s/군$/$keyword/r );
                }
                else {
                    $self->eupmyeon($keyword);
                }
                $self->use_area(1);
                next;
            }
            elsif ( grep {/^$keyword$/} @Postcodify::Area::SIGUGUN ) {
                $self->sigugn($keyword);
                $self->use_area(1);
                next;
            }
            else {
                next if @keywords > $i + 1;
            }
        }
        elsif ( grep { $_ eq $keyword . '시' } @Postcodify::Area::SIGUGUN ) {
            $self->sigugun( $keyword . '시' );
            $self->use_area(1);
            next;
        }
        elsif ( grep { $_ eq $keyword . '군' } @Postcodify::Area::SIGUGUN ) {
            $self->sigugun( $keyword . '군' );
            $self->use_area(1);
            next;
        }

        ## 도로명+건물번호를 확인한다.
        if ( $keyword
            =~ m/^(.+[로길])((?:지하)?([0-9]+(?:-[0-9]+)?)(?:번지?)?)?$/
            )
        {
            $self->road($1);
            $self->sort('JUSO');
            if ( defined $3 ) {
                push @{ $self->numbers }, $3;
                last;
            }
            next;
        }

        ## 동리+지번을 확인한다.
        if ( my ( $dongri, $rest, $number )
            = $keyword
            =~ /^(.{1,5}(?:[0-9]가|[동리가]))(산?([0-9]+(?:-[0-9]+)?)(?:번지?)?)?$/
            )
        {
            $self->dongri( $dongri =~ s/[0-9]([동리])$/$1/r );
            $self->sort('JIBEON');
            if ( defined $number ) {
                push @{ $self->numbers }, $number;
                last;
            }
            next;
        }

        ## 사서함을 확인한다.
        if ( $keyword =~ m/^(.*사서함)(([0-9]+(?:-[0-9]+)?)번?)?$/ ) {
            $self->pobox($1);
            $self->sort('POBOX');
            if ( defined $3 ) {
                push @{ $self->numbers }, $3;
                last;
            }
            next;
        }

        ## 건물번호, 지번, 사서함 번호를 따로 적은 경우를 확인한다.
        if ( $keyword =~ m/^(?:산|지하)?([0-9]+(?:-[0-9]+)?)(?:번지?)?$/ )
        {
            push @{ $self->numbers }, $1;
            last;
        }

        ## 그 밖의 키워드는 건물명으로 취급하되, 동·층·호수는 취급하지 않는다.
        if ( $keyword
            =~ m/(?:[0-9a-z-]+|^[가나다라마바사])[동층호]?$/ )
        {
            push @{ $self->buildings },
                $keyword =~ s/(?:아파트|a(?:pt)?|@)$//r;
            next;
        }

        ## 그 밖의 키워드가 나오면 그만둔다.
        last;
    }

    if ( my $number = shift @{ $self->numbers } ) {
        $self->numbers( [split /-/, $number] );
    }

    return $self;
}

use overload '""' => sub {
    my $self = shift;
    my @address = map { $self->$_ if defined( $self->$_ ) }
        qw/sido sigugun ilbangu eupmyeon dongri road pobox/;
    push @address, join( '-', $self->numbers )   if @{ $self->numbers };
    push @address, join( ' ', $self->buildings ) if @{ $self->buildings };
    return join( ' ', @address );
};


1;
