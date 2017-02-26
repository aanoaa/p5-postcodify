package Postcodify::Result;

# VERSION

use Moo;
use Types::Standard qw/Str ArrayRef/;

use JSON;
use Time::HiRes qw/gettimeofday tv_interval/;

use Postcodify::Util 'trim';

has lang  => ( is => 'ro', isa => Str, default => 'KO' );
has sort  => ( is => 'ro', isa => Str, default => 'JUSO' );
has nums  => ( is => 'ro', isa => Str );
has type  => ( is => 'ro', isa => Str );
has cache => ( is => 'rw', isa => Str, default => 'MISS' );
has time  => ( is => 'ro' );
has resultset => ( is => 'rw', trigger => 1 );
has data => ( is => 'ro', isa => ArrayRef, default => sub { [] } );

sub _trigger_resultset {
    my $self = shift;

    return unless $self->resultset;

    while ( my $row = $self->resultset->next ) {
        ## 한글 도로명 및 지번주소를 정리한다.
        my $ko_base = trim(
            sprintf "%s %s %s %s",
            $row->road->sido_ko     || '',
            $row->road->sigungu_ko  || '',
            $row->road->ilbangu_ko  || '',
            $row->road->eupmyeon_ko || ''
        );
        my $ko_new = trim(
            sprintf "%s %s %s%s",
            $row->road->road_name_ko || '',
            $row->is_basement ? '지하' : '',
            $row->num_major || '',
            $row->num_minor ? '-' . $row->num_minor : ''
        );
        my $ko_old = trim(
            sprintf "%s %s %s%s",
            $row->dongri_ko || '',
            $row->is_mountain ? '산' : '',
            $row->jibeon_major || '',
            $row->jibeon_minor ? '-' . $row->jibeon_minor : ''
        );
        $ko_base =~ s/ {2,}/ /g;
        $ko_new =~ s/ {2,}/ /g;
        $ko_old =~ s/ {2,}/ /g;

        ## 영문 도로명 및 지번주소를 정리한다.
        my $en_base = trim(
            sprintf "%s %s %s %s",
            $row->road->eupmyeon_en || '',
            $row->road->ilbangu_en  || '',
            $row->road->sigungu_en  || '',
            $row->road->sido_en     || ''
        );
        my $en_new = trim(
            sprintf "%s %s%s %s",
            $row->is_basement ? 'Jiha' : '',
            $row->num_major || '',
            $row->num_minor ? '-' . $row->num_minor : '',
            $row->road->road_name_en || ''
        );
        my $en_old = trim(
            sprintf "%s %s%s %s",
            $row->is_mountain ? 'San' : '',
            $row->jibeon_major || '',
            $row->jibeon_minor ? '-' . $row->jibeon_minor : '',
            $row->dongri_en || ''
        );
        $en_base =~ s/ {2,}/ /g;
        $en_new =~ s/ {2,}/ /g;
        $en_old =~ s/ {2,}/ /g;

        ## 추가정보를 정리한다.
        my ( $extra_info_long, $extra_info_short, $other_addresses );
        if ( $self->sort eq 'POBOX' ) {
            $ko_new          = $ko_old           = $row->dongri_ko . ' ' . $row->other_addresses;
            $en_new          = $en_old           = $row->dongri_en . ' ' . $row->other_addresses;
            $extra_info_long = $extra_info_short = $other_addresses = '';
        }
        else {
            $extra_info_long = trim( join( '', $ko_old, $row->building_name || '' ) );
            $extra_info_short = trim( join( '', $row->dongri_ko || '', $row->building_name || '' ) );
            $other_addresses = $row->other_addresses;
        }

        my $data = {
            dbid    => $row->building_id,
            code6   => substr( $row->postcode6, 0, 3 ) . '-' . substr( $row->postcode6, 3, 3 ),
            code5   => $row->postcode5,
            address => {
                base     => $ko_base,
                new      => $ko_new,
                old      => $ko_old,
                building => $row->building_name
            },
            english => {
                base     => $en_base,
                new      => $en_new,
                old      => $en_old,
                building => ''
            },
            other => {
                long   => $extra_info_long,
                short  => $extra_info_short,
                others => $other_addresses,
                addrid => $row->id,
                roadid => $self->sort eq 'POBOX' ? '' : $row->road_id,
                bldnum => $row->building_nums || '',
            }
        };

        push @{ $self->data }, $data;
    }
}

sub json {
    my $self = shift;

    my @data = @{ $self->data };
    return encode_json(
        {
            version => $Postcodify::Result::VERSION || 'development',
            error   => '',
            msg     => '',
            count   => scalar @data,
            time    => sprintf( '%.4f', tv_interval( $self->time ) ),
            lang    => $self->lang,
            sort    => $self->sort,
            type    => $self->type,
            nums    => $self->nums,
            cache   => $self->cache,
            results => [@data]
        }
    ); # utf8 encoded text
}

1;

=pod

=head1 NAME

Postcodify::Result - Contain various search result

=head1 SYNOPSIS

    my $result = Postcodify::Result->new(
        lang      => 'KO',
        sort      => 'JUSO',
        nums      => '123-12',
        type      => 'JUSO+NUMS',
        time      => '0.002',
        resultset => $rs    # PostcodifyRoad prefetched PostcodifyAddress ResultSet
    );

    print $result->json;    # utf8 encoded text

=cut
