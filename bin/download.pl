#!/usr/bin/env perl
use utf8;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;

use Encode qw/decode_utf8/;
use HTTP::Tiny;
use Path::Tiny;
use URI::Encode qw/uri_encode uri_decode/;

binmode STDOUT, ":encoding(UTF-8)";
binmode STDERR, ":encoding(UTF-8)";

our $ADDR_URL          = 'http://www.juso.go.kr/dn.do?reqType=ALLMTCHG&fileName=YYYYMM%EC%A3%BC%EC%86%8CDB_%EC%A0%84%EC%B2%B4%EB%B6%84.zip&realFileName=YYYYMMALLMTCHG00.zip&regYmd=YYYY&ctprvnCd=00&gubun=MTCH&stdde=YYYYMM';
our $ADDR_BUILDING_URL = 'http://www.juso.go.kr/dn.do?reqType=ALLRDNM&fileName=YYYYMM%EA%B1%B4%EB%AC%BCDB_%EC%A0%84%EC%B2%B4%EB%B6%84.zip&realFileName=YYYYMMALLRDNM00.zip&regYmd=YYYY&ctprvnCd=00&gubun=RDNM&stdde=YYYYMM';

our $ADDR_PATCH_URL          = 'http://www.juso.go.kr/dn.do?reqType=ALLMTCHG&fileName=YYYYMM%EC%A3%BC%EC%86%8CDB_%EB%B3%80%EB%8F%99%EB%B6%84.zip&realFileName=YYYYMMALLMTCHG01.zip&regYmd=YYYY&ctprvnCd=01&gubun=MTCH&stdde=YYYYMM';
our $ADDR_BUILDING_PATCH_URL = 'http://www.juso.go.kr/dn.do?reqType=ALLRDNM&fileName=YYYYMM%EA%B1%B4%EB%AC%BCDB_%EB%B3%80%EB%8F%99%EB%B6%84.zip&realFileName=YYYYMMALLRDNM01.zip&regYmd=YYYY&ctprvnCd=01&gubun=RDNM&stdde=YYYYMM';

our $POBOX_URL           = 'https://www.epost.go.kr/search/areacd/areacd_pobox_DB.zip';
our $RANGES_URL          = 'https://www.epost.go.kr/search/areacd/areacd_rangeaddr_DB.zip';
our $OLDADDR_ZIPCODE_URL = 'http://cdn.poesis.kr/archives/oldaddr_zipcode_DB.zip';
our $OLDADDR_SPECIAL_URL = 'http://cdn.poesis.kr/archives/oldaddr_special_DB.zip';

our @REST = ( $POBOX_URL, $RANGES_URL, $OLDADDR_ZIPCODE_URL, $OLDADDR_SPECIAL_URL );

my %options;
GetOptions(\%options, "--help", "--force|f", "--year|y=i", "--month|m=i");

run(\%options, @ARGV);

sub run {
    my ($opts, @args) = @_;

    pod2usage(0) if $opts->{help};

    my @time = localtime;
    my $year = $time[5] + 1900;
    my $month = sprintf('%02d', $time[4] + 1);

    $year  = $opts->{year}  if $opts->{year};
    $month = $opts->{month} if $opts->{month};

    $month = sprintf('%02d', $month);

    my $http = HTTP::Tiny->new;
    for my $url ($ADDR_URL, $ADDR_BUILDING_URL, $ADDR_PATCH_URL, $ADDR_BUILDING_PATCH_URL, @REST) {
        $url = uri_decode($url);
        $url = decode_utf8($url);
        $url =~ s/YYYY/$year/g;
        $url =~ s/MM/$month/g;

        my $isAddr;
        my $filename;
        if ($url =~ m/zip$/) {
            ($filename) = $url =~ m/(\w+\.zip)$/;
        } else {
            ($filename) = $url =~ m/fileName=([^&]+)/;
            $isAddr = 1;
        }
        die "Failed to parse filename" unless $filename;

        printf "[%s] downloading ... ", $filename;
        my $zip = path("./data/$filename");
        if ($zip->exists) {
            print "OK(Cache hit: use `force' option to ignore cache)\n";
        } else {
            $zip->parent->mkpath;

            my $res = $http->mirror(uri_encode($url), "$zip");
            die "$res->{status} $res->{reason}" unless $res->{success};

            ## 서버에서 not found 에 대해 정상으로 응답하기 때문에
            ## 파일 사이즈가 넘 작으면 에러로 판단
            my @stat = stat $zip->openr_raw;
            if ($stat[7] < 10000) {
                print "Failed\n";
                if ($isAddr) {
                    print STDERR "$year-$month 에 해당하는 데이터가 없는 것 같습니다.\n";
                    print STDERR "http://www.juso.go.kr/addrlink/main.do 에서 확인 후에 year, month 옵션을 조정해보세요.\n";
                }

                $zip->remove;
            } else {
                print "OK\n";
            }
        }
    }
}

__END__

=encoding utf8

=head1 NAME

download.pl - Download address data files.

=head1 SYNOPSIS

    $ perl bin/download.pl [options]

       -h, --help    print this help.
       -f, --force   Download file if files are already exisits.
       -y, --year
       -m, --month

=head1 AUTHOR

Hyungsuk Hong

=cut
