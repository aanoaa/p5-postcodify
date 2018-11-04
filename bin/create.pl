#!/usr/bin/env perl
use strict;
use warnings;

use Postcodify;
use Postcodify::Importer;

my $p = Postcodify->new;
my $importer = Postcodify::Importer->new($p->schema);

$importer->create_tables;

# create tables
# load basic info
# load road list
# load new ranges
# load old ranges
# initial indexes
# load addresses
# interim indexes
# load jibeon
# load pobox
# save english keywords
# final indexes
