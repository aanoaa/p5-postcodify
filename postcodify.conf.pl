{
    ## SQLite
    # postcodify => {
    #     dsn            => 'dbi:SQLite:dbname=db/postcodify.20141112.v2.sqlite',
    #     quote_char     => q{`},
    #     sqlite_unicode => 1
    # },
    ## MySQL
    postcodify => {
        dsn               => 'dbi:mysql:postcodify:127.0.0.1',
        name              => 'postcodify',
        user              => 'postcodify',
        password          => 'postcodify',
        quote_char        => q{`},
        mysql_enable_utf8 => 1,
        on_connect_do     => 'SET NAMES utf8'
    },
};
