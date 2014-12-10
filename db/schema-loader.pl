use strict;
use warnings;
use lib 'lib';
use Postcodify;
my $p            = Postcodify->new;
my $connect_info = $p->config->{postcodify};
$connect_info->{pass} = delete $connect_info->{password}
    if $connect_info->{dsn} =~ /mysql/i;
{
    schema_class   => "Postcodify::Schema",
    connect_info   => $connect_info,
    loader_options => {
        dump_directory            => 'lib',
        naming                    => { ALL => 'v8' },
        skip_load_external        => 1,
        relationships             => 1,
        col_collision_map         => 'column_%s',
        result_base_class         => 'Postcodify::Schema::Base',
        overwrite_modifications   => 1,
        datetime_undef_if_invalid => 1,
    },
}
