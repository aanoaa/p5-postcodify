use utf8;
use strict;
use warnings;
use Data::Dump;

use Postcodify::Query;

binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $keyword = '서울시 광진구 자양동 48-3번지';
my $q       = Postcodify::Query->new;
$q->parse($keyword);
print "$keyword\n";
print "$q\n";
dd $q;
