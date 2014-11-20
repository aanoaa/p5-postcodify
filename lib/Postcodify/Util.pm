package Postcodify::Util;

use strict;
use warnings;

use Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(trim);

sub trim {
    my $str = shift;
    $str =~ s/^\s+|\s+$//g;
    return $str;
}

1;
