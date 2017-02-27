use utf8;
use strict;
use warnings;
use Encode 'decode_utf8';

use lib 'lib';
use Postcodify::Query;

die "Usage: $0 <query>" unless @ARGV;

binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $q = Postcodify::Query->new;
$q->parse( decode_utf8( join( ' ', @ARGV ) ) );
print "$q\n";
print "---------------------\n";
for my $key (qw/sido sigungu ilbangu eupmyeon dongri road pobox use_area lang sort/) {
    printf( "%s: %s\n", $key, $q->$key || '' );
}

for my $key (qw/numbers buildings/) {
    printf( "%s: %s\n", $key, join( ', ', @{ $q->$key } ) );
}
