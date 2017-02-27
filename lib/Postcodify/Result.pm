package Postcodify::Result;

# VERSION

use utf8;
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
        my $road      = $row->road;
        my $ko_common = trim(
            sprintf "%s %s %s %s",
            $road->sido_ko     || '',
            $road->sigungu_ko  || '',
            $road->ilbangu_ko  || '',
            $road->eupmyeon_ko || ''
        );
        my $ko_doro = trim(
            sprintf "%s %s %s%s",
            $road->road_name_ko || '',
            $row->is_basement ? '지하' : '',
            $row->num_major || '',
            $row->num_minor ? '-' . $row->num_minor : ''
        );
        my $ko_jibeon = trim(
            sprintf "%s %s %s%s",
            $row->dongri_ko || '',
            $row->is_mountain ? '산' : '',
            $row->jibeon_major || '',
            $row->jibeon_minor ? '-' . $row->jibeon_minor : ''
        );
        $ko_common =~ s/ {2,}/ /g;
        $ko_doro =~ s/ {2,}/ /g;
        $ko_jibeon =~ s/ {2,}/ /g;

        ## 영문 도로명 및 지번주소를 정리한다.
        my $en_common = trim(
            sprintf "%s %s %s %s",
            $road->eupmyeon_en ? $road->eupmyeon_en . ', ' : '',
            $road->ilbangu_en  ? $road->ilbangu_en . ', '  : '',
            $road->sigungu_en  ? $road->sigungu_en . ', '  : '',
            $road->sido_en || ''
        );
        my $en_doro = trim(
            sprintf "%s %s%s, %s",
            $row->is_basement ? 'Jiha' : '',
            $row->num_major || '',
            $row->num_minor ? '-' . $row->num_minor : '',
            $road->road_name_en || ''
        );
        my $en_jibeon = trim(
            sprintf "%s %s%s, %s",
            $row->is_mountain ? 'San' : '',
            $row->jibeon_major || '',
            $row->jibeon_minor ? '-' . $row->jibeon_minor : '',
            $row->dongri_en || ''
        );
        $en_common =~ s/ {2,}/ /g;
        $en_doro =~ s/ {2,}/ /g;
        $en_jibeon =~ s/ {2,}/ /g;

        ## 추가정보를 정리한다.
        my ( $extra_info_long, $extra_info_short, $other_addresses );
        if ( $self->sort eq 'POBOX' ) {
            $ko_doro         = $ko_jibeon        = $row->dongri_ko . ' ' . $row->other_addresses;
            $en_doro         = $en_jibeon        = $row->dongri_en . ' ' . $row->other_addresses;
            $extra_info_long = $extra_info_short = $other_addresses = '';
        }
        else {
            $extra_info_long = trim( join( '', $ko_jibeon, $row->building_name || '' ) );
            $extra_info_short = trim( join( '', $row->dongri_ko || '', $row->building_name || '' ) );
            $other_addresses = $row->other_addresses;
        }

        my $data = {
            postcode5       => $row->postcode5,
            postcode6       => $row->postcode6,
            ko_common       => $ko_common,
            ko_doro         => $ko_doro,
            ko_jibeon       => $ko_jibeon,
            en_common       => $en_common,
            en_doro         => $en_doro,
            en_jibeon       => $en_jibeon,
            building_id     => $row->building_id,
            building_name   => $row->building_name || '',
            building_nums   => $row->building_nums || '',
            other_addresses => $other_addresses || '',
            road_id         => $self->sort eq 'POBOX' ? '' : substr( $row->road_id, 0, 12 ),
            internal_id     => $row->id,
        };

        push @{ $self->data }, $data;
    }
}

sub json {
    my $self = shift;

    my @data = @{ $self->data };
    return encode_json(
        {
            # for compartible js library
            version => $Postcodify::Result::VERSION || 'v3.0.0',
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
