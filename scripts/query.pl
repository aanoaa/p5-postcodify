use utf8;
use strict;
use warnings;
use Encode 'decode_utf8';
use Data::Dump;
use Data::Printer;

use lib 'lib';
use Postcodify::Query;

die "Usage: $0 <query>" unless @ARGV;

binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $q = Postcodify::Query->new;
$q->parse( decode_utf8( join( ' ', @ARGV ) ) );
print "$q\n";
p $q;
