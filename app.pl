#!/usr/bin/env perl
use Mojolicious::Lite;

use Encode qw/decode_utf8/;
use Postcodify;

plugin 'Config';

app->defaults(
    postcodify => Postcodify->new( config => $ENV{MOJO_CONFIG} || './postcodify.conf.pl' ),
);

helper error => sub {
    my ($c, $status, $error) = @_;

    $c->render(json => { status => $status, json => { error => $error || q{} } });
    return;
};

get '/' => sub {
    my $c = shift;
    my $q = $c->req->param('q');
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    if ( length $q < 3 || length $q > 80 ) {
        return $c->error( 400, { str => 'Query is too long or too short : ' . $q } );
    }

    my $p = app->defaults('postcodify');
    my $result = $p->search($q);
    $c->render( text => decode_utf8( $result->json ), format => 'json' );
};

app->start;
