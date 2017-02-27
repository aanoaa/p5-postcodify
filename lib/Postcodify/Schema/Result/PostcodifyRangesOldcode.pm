use utf8;
package Postcodify::Schema::Result::PostcodifyRangesOldcode;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Postcodify::Schema::Result::PostcodifyRangesOldcode

=cut

use strict;
use warnings;


=head1 BASE CLASS: L<Postcodify::Schema::Base>

=cut

use base 'Postcodify::Schema::Base';

=head1 TABLE: C<postcodify_ranges_oldcode>

=cut

__PACKAGE__->table("postcodify_ranges_oldcode");

=head1 ACCESSORS

=head2 seq

  data_type: 'integer'
  is_nullable: 0

=head2 sido_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 sido_en

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 sigungu_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 sigungu_en

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 ilbangu_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 ilbangu_en

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 eupmyeon_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 eupmyeon_en

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 dongri_ko

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 dongri_en

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 range_start_major

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 range_start_minor

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 range_end_major

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 range_end_minor

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 is_mountain

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

=head2 island_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 building_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 building_num_start

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 building_num_end

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 postcode6

  data_type: 'char'
  is_nullable: 1
  size: 6

=cut

__PACKAGE__->add_columns(
  "seq",
  { data_type => "integer", is_nullable => 0 },
  "sido_ko",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "sido_en",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "sigungu_ko",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "sigungu_en",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "ilbangu_ko",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "ilbangu_en",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "eupmyeon_ko",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "eupmyeon_en",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "dongri_ko",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "dongri_en",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "range_start_major",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "range_start_minor",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "range_end_major",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "range_end_minor",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "is_mountain",
  { data_type => "tinyint", default_value => 0, is_nullable => 1 },
  "island_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "building_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "building_num_start",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "building_num_end",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "postcode6",
  { data_type => "char", is_nullable => 1, size => 6 },
);

=head1 PRIMARY KEY

=over 4

=item * L</seq>

=back

=cut

__PACKAGE__->set_primary_key("seq");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-02-24 07:00:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:o+nH16IsJo/1asl/QlFMqg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
