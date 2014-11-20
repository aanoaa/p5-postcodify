#!/usr/bin/env perl
use utf8;
use strict;
use warnings;
use Encode 'decode_utf8';
use Postcodify;

binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $p      = Postcodify->new;
my $result = $p->search('서울 광진구 화양동 48-3번지 웅진빌딩');
print decode_utf8( $result->json ), "\n";
