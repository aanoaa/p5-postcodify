use utf8;
package Postcodify::Schema::Result::PostcodifyRoad;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Postcodify::Schema::Result::PostcodifyRoad

=cut

use strict;
use warnings;


=head1 BASE CLASS: L<Postcodify::Schema::Base>

=cut

use base 'Postcodify::Schema::Base';

=head1 TABLE: C<postcodify_roads>

=cut

__PACKAGE__->table("postcodify_roads");

=head1 ACCESSORS

=head2 road_id

  data_type: 'decimal'
  is_nullable: 0
  size: [14,0]

=head2 road_name_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 road_name_en

  data_type: 'varchar'
  is_nullable: 1
  size: 120

=head2 sido_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 sido_en

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 sigungu_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 sigungu_en

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 ilbangu_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 ilbangu_en

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 eupmyeon_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 eupmyeon_en

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 updated

  data_type: 'decimal'
  is_nullable: 1
  size: [8,0]

=cut

__PACKAGE__->add_columns(
  "road_id",
  { data_type => "decimal", is_nullable => 0, size => [14, 0] },
  "road_name_ko",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "road_name_en",
  { data_type => "varchar", is_nullable => 1, size => 120 },
  "sido_ko",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "sido_en",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "sigungu_ko",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "sigungu_en",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "ilbangu_ko",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "ilbangu_en",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "eupmyeon_ko",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "eupmyeon_en",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "updated",
  { data_type => "decimal", is_nullable => 1, size => [8, 0] },
);

=head1 PRIMARY KEY

=over 4

=item * L</road_id>

=back

=cut

__PACKAGE__->set_primary_key("road_id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-02-24 07:00:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Szm8TWvi2GJWxqGFGfix0g

__PACKAGE__->has_many(
  "addresses",
  "Postcodify::Schema::Result::PostcodifyAddress",
  { "foreign.road_id" => "self.road_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

1;
