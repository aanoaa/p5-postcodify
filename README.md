# NAME #

p5-postcodify

# REQUIREMENTS #

    $ cpanm --installdeps .

# Choose database #

configure in `postcodify.conf.pl`

## SQLite data file ##

    # requires 2GB+ disk
    $ cd db/
    $ wget http://storage.poesis.kr/downloads/post/postcodify.20141112.v2.sqlite.xz
    $ xz -d postcodify.20141112.v2.sqlite.xz

    # or just
    $ wget -qO- https://raw.githubusercontent.com/aanoaa/p5-postcodify/develop/installer.sh | sh

    # does not have `wget`?
    $ curl https://raw.githubusercontent.com/aanoaa/p5-postcodify/develop/installer.sh | sh

## MySQL data file ##

    $ wget http://storage.poesis.kr/downloads/post/postcodify.20141201.v2.mysqldump.xz
    $ xz -d postcodify.20141201.v2.mysqldump.xz
    $ mysql -u root -p -e 'GRANT ALL PRIVILEGES ON `postcodify`.* TO postcodify@localhost IDENTIFIED by "s3cr3t";'    # WARN: type your own secret password
    $ mysql -u postcodify -p -e 'CREATE DATABASE `postcodify` DEFAULT CHARACTER SET utf8;'
    $ mysql -u postcodify -p postcodify < postcodify.20141201.v2.mysqldump

# TEST #

    $ cpanm Encode
    $ perl scripts/search.pl 서울시 강남구 논현동 99-1

    # web application
    $ cpanm Plack
    $ plackup -Ilib   # http://localhost:5000

# SEE ALSO #

[postcodify](https://github.com/kijin/postcodify)
