#!/usr/bin/env perl
use utf8;
use strict;
use warnings;
use Postcodify;

binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $p = Postcodify->new;
$p->search('서울시 광진구 화양동 48-3번지 웅진빌딩 403호');
