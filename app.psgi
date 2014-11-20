use Plack::App::File;
use Plack::Builder;
use Plack::Request;

use Encode 'decode_utf8';

use Postcodify;

binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $app = Plack::App::File->new( file => "./examples/index.html" )->to_app;

builder {
    mount '/'       => $app;
    mount '/search' => sub {
        my $env    = shift;
        my $req    = Plack::Request->new($env);
        my $query  = $req->param('q');
        my $p      = Postcodify->new;
        my $result = $p->search( decode_utf8($query) );
        return [200, ['Content-Type' => 'application/json'], [$result->json]];
    };
};
