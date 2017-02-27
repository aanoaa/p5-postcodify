use utf8;
package Postcodify::Schema::Result::PostcodifyRangesJibeon;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Postcodify::Schema::Result::PostcodifyRangesJibeon

=cut

use strict;
use warnings;


=head1 BASE CLASS: L<Postcodify::Schema::Base>

=cut

use base 'Postcodify::Schema::Base';

=head1 TABLE: C<postcodify_ranges_jibeon>

=cut

__PACKAGE__->table("postcodify_ranges_jibeon");

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

=head2 admin_dongri

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 postcode5

  data_type: 'char'
  is_nullable: 1
  size: 5

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
  "admin_dongri",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "postcode5",
  { data_type => "char", is_nullable => 1, size => 5 },
);

=head1 PRIMARY KEY

=over 4

=item * L</seq>

=back

=cut

__PACKAGE__->set_primary_key("seq");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-02-24 07:00:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:105f4tz5SNMtJy2cRGZxqw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
