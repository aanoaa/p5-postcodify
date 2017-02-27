#!/usr/bin/env perl
use utf8;
use strict;
use warnings;
use Encode 'decode_utf8';

use lib 'lib';

use Postcodify;

die "Usage: $0 <query>" unless @ARGV;

binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $p      = Postcodify->new;
my $result = $p->search( decode_utf8( join( ' ', @ARGV ) ) );
my $json   = decode_utf8( $result->json );
print length $json > 200 ? substr( $json, 0, 200 ) . '...' : $json, "\n";
