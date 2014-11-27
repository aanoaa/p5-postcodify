# NAME #

p5-postcodify

# REQUIREMENTS #

    $ cpanm --installdeps .

## SQLite data file ##

    # requires 2GB+ disk
    $ cd db/
    $ wget http://storage.poesis.kr/downloads/post/postcodify.20141112.v2.sqlite.xz
    $ xz -d postcodify.20141112.v2.sqlite.xz

    # or just
    $ wget -qO- https://raw.githubusercontent.com/aanoaa/p5-postcodify/develop/installer.sh | sh

    # does not have `wget`?
    $ curl https://raw.githubusercontent.com/aanoaa/p5-postcodify/develop/installer.sh | sh

# TEST #

    # cpanm Plack
    $ plackup -Ilib   # http://localhost:5000

# SEE ALSO #

[postcodify](https://github.com/kijin/postcodify)
