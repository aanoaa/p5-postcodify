# NAME #

p5-postcodify

# REQUIREMENTS #

    $ cpanm --installdeps .

# Choose database #

configure in `postcodify.conf.pl`

## MySQL data file ##

    $ wget http://storage.poesis.kr/downloads/post/postcodify.20161230.v3.mysqldump.xz
    $ xz -d postcodify.20161230.v3.mysqldump.xz
    $ mysql -u root -p -e 'GRANT ALL PRIVILEGES ON `postcodify`.* TO postcodify@localhost IDENTIFIED by "s3cr3t";'    # WARN: type your own secret password
    $ mysql -u postcodify -p -e 'CREATE DATABASE `postcodify` DEFAULT CHARACTER SET utf8;'
    $ mysql -u postcodify -p postcodify < postcodify.20161230.v3.mysqldump

# TEST #

    $ cpanm Encode    # scripts/search.pl requirements
    $ perl scripts/search.pl 서울시 강남구 논현동 99-1

# SEE ALSO #

[postcodify](https://github.com/kijin/postcodify)
