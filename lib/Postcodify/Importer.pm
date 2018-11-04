package Postcodify::Importer;

use strict;
use warnings;

use Path::Tiny;
use Data::Dump;

sub new {
    my ($class, $schema) = @_;
    return bless { schema => $schema }, $class;
}

sub create_tables {
    my $self = shift;

    my $connect_info = $self->{schema}->storage->connect_info->[0];
    my $dsn = $connect_info->{dsn};
    my $host = (split(/:/, $dsn))[-1];
    my $cmd = sprintf(
        "mysql -h %s -u %s -p%s %s < ./db/schema.sql",
        $host,
        $connect_info->{user},
        $connect_info->{password},
        $connect_info->{name}
    );

    print "Create tables ...\n";
    my $exit = system($cmd);
    die $! if $exit != 0;

    print "OK\n";
}

1;
