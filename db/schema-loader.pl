use strict;
use warnings;
{
    schema_class => "Postcodify::Schema",
    connect_info =>
        { dsn => "dbi:SQLite:dbname=db/postcodify.20141112.v2.sqlite" },
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
