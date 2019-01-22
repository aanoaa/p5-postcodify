FROM perl:5
MAINTAINER Hyungsuk Hong <aanoaa@gmail.com>

RUN apt-get update && apt-get install -y \
        libmariadbclient-dev \
        libssl-dev \
        sqlite3 \
        && apt-get clean

RUN cpanm --notest Net::SSLeay IO::Socket::SSL DBD::mysql

RUN useradd postcodify
WORKDIR /tmp
COPY cpanfile cpanfile
RUN cpanm --notest --installdeps .
ENV MOJO_HOME=/home/postcodify
ENV MOJO_CONFIG=./postcodify.conf.pl
ENV PERL5LIB=$PERL5LIB:./lib
# Everything up to cached.

WORKDIR /home/postcodify
COPY . .
RUN chown -R postcodify:postcodify .
USER postcodify

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["hypnotoad"]

EXPOSE 5000
