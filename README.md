# NAME #

p5-postcodify

# REQUIREMENTS #

    $ cpanm --installdeps .

    # download sqlite file    # 2GB+
    $ cd db/
    $ wget http://storage.poesis.kr/downloads/post/postcodify.20141112.v2.sqlite.xz
    $ xz -d postcodify.20141112.v2.sqlite.xz

# TEST #

    # cpanm Plack
    $ plackup    # http://localhost:5000

# SEE ALSO #

[postcodify](https://github.com/kijin/postcodify)
