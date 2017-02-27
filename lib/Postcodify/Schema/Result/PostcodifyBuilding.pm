use utf8;
package Postcodify::Schema::Result::PostcodifyBuilding;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Postcodify::Schema::Result::PostcodifyBuilding

=cut

use strict;
use warnings;


=head1 BASE CLASS: L<Postcodify::Schema::Base>

=cut

use base 'Postcodify::Schema::Base';

=head1 TABLE: C<postcodify_buildings>

=cut

__PACKAGE__->table("postcodify_buildings");

=head1 ACCESSORS

=head2 seq

  data_type: 'integer'
  is_nullable: 0

=head2 address_id

  data_type: 'integer'
  is_nullable: 0

=head2 keyword

  data_type: 'varchar'
  is_nullable: 1
  size: 5000

=cut

__PACKAGE__->add_columns(
  "seq",
  { data_type => "integer", is_nullable => 0 },
  "address_id",
  { data_type => "integer", is_nullable => 0 },
  "keyword",
  { data_type => "varchar", is_nullable => 1, size => 5000 },
);

=head1 PRIMARY KEY

=over 4

=item * L</seq>

=back

=cut

__PACKAGE__->set_primary_key("seq");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-02-24 07:00:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mPnj1JPD+zVqeFVS1jSjsA

__PACKAGE__->belongs_to(
  "address",
  "Postcodify::Schema::Result::PostcodifyAddress",
  { address_id => "id" },
  {
    is_deferrable => 0,
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

1;
