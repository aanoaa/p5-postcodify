package Postcodify;

use Moo;

use String::CRC32 'crc32';

use Postcodify::Query;
use Postcodify::Result;
use Postcodify::Schema;

has config => (
    is      => 'ro',
    coerce  => sub { do shift },
    default => sub { $ENV{POSTCODIFY_CONF} || './postcodify.conf.pl' }
);

has schema => ( is => 'lazy' );

sub _build_schema {
    my $db = shift->config->{db};
    return Postcodify::Schema->connect(
        {
            dsn            => "dbi:SQLite:dbname=$db",
            quote_char     => q{`},
            sqlite_unicode => 1,
        }
    );
}

sub search {
    my ( $self, $keyword ) = @_;
    return unless $keyword;
    if ( length $keyword < 3 || length $keyword > 80 ) {
        warn "Keyword is Too Long or Too Short\n";
        return;
    }

    my $q = Postcodify::Query->new;
    $q->parse($keyword);
    ## TODO: memcache
    my $search_type = 'NONE';
    my ( %cond, %attr, $rs );
    my $address = $self->schema->resultset('PostcodifyAddress');
    ## http://search.cpan.org/~ribasushi/DBIx-Class/lib/DBIx/Class/Manual/Cookbook.pod#Multi-step_and_multiple_joins
    $attr{join}     = [];
    $attr{prefetch} = 'road';
    $attr{distinct} = 1;
    if ( $q->use_area ) {
        $cond{sido_ko}     = $q->sido     if $q->sido;
        $cond{sigungu_ko}  = $q->sigungu  if $q->sigungu;
        $cond{ilbangu_ko}  = $q->ilbangu  if $q->ilbangu;
        $cond{eupmyeon_ko} = $q->eupmyeon if $q->eupmyeon;
    }

    ## 도로명주소로 검색하는 경우
    if ( $q->road && !@{ $q->buildings } ) {
        $search_type = 'JUSO';
        push @{ $attr{join} }, 'keywords';
        if ( $q->lang eq 'KO' ) {
            $cond{keyword_crc32} = crc32( $q->road );
        }
        else {
            pop @{ $attr{join} };
            push @{ $attr{join} }, { 'keywords' => 'english' };
            $cond{'english.en_crc32'} = crc32( $q->road );
        }

        if ( @{ $q->numbers } ) {
            $search_type .= '+NUMS';
            push @{ $attr{join} }, 'numbers';
            $cond{'me.num_major'} = $q->numbers->[0];
            $cond{'me.num_minor'} = $q->numbers->[1] if $q->numbers->[1];
        }

        $rs = $address->search( \%cond, \%attr );
    }
    ## 지번주소로 검색하는 경우
    elsif ( $q->dongri && !@{ $q->buildings } ) {
        $search_type = 'JIBEON';
        push @{ $attr{join} }, 'keywords';
        if ( $q->lang eq 'KO' ) {
            $cond{keyword_crc32} = crc32( $q->dongri );
        }
        else {
            pop @{ $attr{join} };
            push @{ $attr{join} }, { 'keywords' => 'english' };
            $cond{'english.en_crc32'} = crc32( $q->dongri );
        }

        ## 번지수 쿼리를 작성한다.
        if ( $q->numbers->[0] ) {
            my $search_type .= '+NUMS';
            push @{ $attr{join} }, 'numbers';
            $cond{'me.num_major'} = $q->numbers->[0];
            $cond{'me.num_minor'} = $q->numbers->[1] if $q->numbers->[1];
        }

        ## 일단 검색해 본다.
        $rs = $address->search( \%cond, \%attr );

        ## 검색 결과가 없다면 건물명을 동리로 잘못 해석했을 수도 있으므로 건물명 검색을 다시 시도해 본다.
        if ( !@{ $q->numbers } && !$rs->count && $q->lang eq 'KO' ) {
            push @{ $attr{join} }, 'buildings';
            $cond{'buildings.keyword'} = { -like => '%' . $q->dongri . '%' };
            $rs = $address->search( \%cond, \%attr );
            if ( $rs->count ) {
                $search_type = 'BUILDING';
                $q->sort('JUSO');
            }
        }
    }
    ## 건물명만으로 검색하는 경우
    elsif ( @{ $q->buildings } && !$q->road && !$q->dongri ) {
        $search_type = 'BUILDING';
        push @{ $attr{join} }, 'buildings';
        for my $building ( @{ $q->buildings } ) {
            $cond{'buildings.keyword'} = { -like => '%' . $building . '%' };
        }
        $rs = $address->search( \%cond, \%attr );
    }
    ## 도로명 + 건물명으로 검색하는 경우
    elsif ( @{ $q->buildings } && $q->road ) {
        $search_type = 'BUILDING+JUSO';
        push @{ $attr{join} }, 'keywords', 'buildings';
        $cond{keyword_crc32} = crc32( $q->road );
        for my $building ( @{ $q->buildings } ) {
            $cond{'buildings.keyword'} = { -like => '%' . $building . '%' };
        }
        $rs = $address->search( \%cond, \%attr );
    }
    ## 동리 + 건물명으로 검색하는 경우
    elsif ( @{ $q->buildings } && $q->dongri ) {
        $search_type = 'BUILDING+DONG';
        push @{ $attr{join} }, 'keywords', 'buildings';
        $cond{keyword_crc32} = crc32( $q->dongri );
        for my $building ( @{ $q->buildings } ) {
            $cond{'buildings.keyword'} = { -like => '%' . $building . '%' };
        }
        $rs = $address->search( \%cond, \%attr );
    }
    ## 사서함으로 검색하는 경우
    elsif ( $q->pobox ) {
        $search_type = 'POBOX';
        push @{ $attr{join} }, 'poboxes';
        $cond{keyword} = { -like => '%' . $q->pobox . '%' };
        if ( my $major = $q->numbers->[0] ) {
            $cond{'pobox.range_start_major'} = { '<=' => $major };
            $cond{'pobox.range_end_major'}   = { '>=' => $major };
            if ( my $minor = $q->numbers->[1] ) {
                $cond{'pobox.range_start_minor'} = {
                    -or => [
                        'pobox.range_start_minor' => undef,
                        -and                      => [
                            'pobox.range_start_minor' => { '<=' => $minor },
                            'pobox.range_end_minor'   => { '>=' => $minor },
                        ]
                    ]
                };
            }
        }

        $rs = $address->search( \%cond, \%attr );
    }
    ## 읍면으로 검색하는 경우
    elsif ( $q->use_area && $q->eupmyeon ) {
        $search_type = 'EUPMYEON';
        $cond{postcode5} = { '!=' => undef };
        $rs = $address->search( \%cond, \%attr );

        ## 검색 결과가 없다면 건물명을 읍면으로 잘못 해석했을 수도 있으므로 건물명 검색을 다시 시도해 본다.
        if ( !$rs->count && $q->lang eq 'KO' ) {
            ## TODO: 여기서 엄청느림
            push @{ $attr{join} }, 'buildings';
            $cond{'buildings.keyword'} = { -like => '%' . $q->eupmyeon . '%' };
            $rs = $address->search( \%cond, \%attr );
            if ( $rs->count ) {
                $search_type = 'BUILDING';
                $q->sort('JUSO');
            }
        }
    }
    ## 그 밖의 경우 검색 결과가 없는 것으로 한다.

    return Postcodify::Result->new(
        lang      => $q->lang,
        sort      => $q->sort,
        nums      => join( '-', @{ $q->numbers } ),
        type      => $search_type,
        resultset => $rs
    );
}

1;
