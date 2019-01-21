my $PORT = $ENV{PORT} || 5000;
{
    ## MySQL
    postcodify => {
        dsn               => $ENV{POSTCODIFY_DSN}      || 'dbi:mysql:postcodify:127.0.0.1',
        name              => $ENV{POSTCODIFY_NAME}     || 'postcodify',
        user              => $ENV{POSTCODIFY_USERNAME} || 'postcodify',
        password          => $ENV{POSTCODIFY_PASSWORD} || 'postcodify',
        quote_char        => q{`},
        mysql_enable_utf8 => 1,
        on_connect_do     => 'SET NAMES utf8'
    },
    hypnotoad => {
        listen   => ["http://*:$PORT"],
        workers  => 5,
        pid_file => 'hypnotoad.pid',
    },
};
