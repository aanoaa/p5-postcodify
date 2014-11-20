use utf8;

use open ':std', ':encoding(utf8)';
use Test::More;

use Postcodify;

my $p = Postcodify->new;

subtest '도로명주소로 검색하는 경우' => sub {
    my ($result) = $p->search('서울시 종로구 세종대로 175');
    my $sql = as_query( $result->resultset );
    like $sql, qr/keyword_crc32/;
    like $sql, qr/`me`.`num_major` =/;

    ($result) = $p->search('175, sejongdaero, Jongro-gu, Seoul');
    $sql = as_query( $result->resultset );
    like $sql, qr/LEFT JOIN `postcodify_english`/;
    like $sql, qr/en_crc32/;
};

subtest '지번주소로 검색하는 경우' => sub {
    my ($result) = $p->search('서울시 광진구 화양동 48-3번지');
    my $sql = as_query( $result->resultset );
    like $sql, qr/JOIN `postcodify_keywords`/;
    like $sql, qr/crc32/;
    like $sql, qr/`me`.`num_major` =/;
    like $sql, qr/`me`.`num_minor` =/;

    ($result)
        = $p->search(
        '48-3, Hwayang-dong, Gwangjin-gu, Seoul, 143-917 Rep. of KOREA');
    $sql = as_query( $result->resultset );
    like $sql, qr/LEFT JOIN `postcodify_english`/;
    like $sql, qr/en_crc32/;
    like $sql, qr/`me`.`num_major` =/;
    like $sql, qr/`me`.`num_minor` =/;
};

subtest '건물명만으로 검색하는 경우' => sub {
    my ($result) = $p->search('웅진빌딩 403호');
    my $sql = as_query( $result->resultset );
    like $sql, qr/JOIN `postcodify_buildings`/;
    like $sql, qr/LIKE/;
};

subtest '도로명 + 건물명으로 검색하는 경우' => sub {
    my ($result) = $p->search('아차산로 웅진빌딩 403호');
    my $sql = as_query( $result->resultset );
    like $sql, qr/JOIN `postcodify_keywords`/;
    like $sql, qr/JOIN `postcodify_buildings`/;
    like $sql, qr/LIKE/;
};

subtest '동리 + 건물명으로 검색하는 경우' => sub {
    my ($result) = $p->search('화양동 웅진빌딩 403호');
    my $sql = as_query( $result->resultset );
    like $sql, qr/JOIN `postcodify_keywords`/;
    like $sql, qr/JOIN `postcodify_buildings`/;
    like $sql, qr/LIKE/;
};

subtest '사서함으로 검색하는 경우' => sub {
    my ($result) = $p->search('사서함 400번');
    my $sql = as_query( $result->resultset );
    like $sql, qr/JOIN `postcodify_pobox`/;
    like $sql, qr/range_start_major/;
    like $sql, qr/range_end_major/;
};

subtest '읍면으로 검색하는 경우' => sub {
    my ($result) = $p->search('충남 서산시 고북면');
    my $sql = as_query( $result->resultset );
    like $sql, qr/postcode5/;
    ($result) = $p->search('짜장면');
    $sql = as_query( $result->resultset );
    like $sql, qr/JOIN `postcodify_buildings`/;
};

done_testing();

sub as_query {
    my $rs = shift;
    return unless $rs;

    my $query = $rs->as_query;
    my ( $sql, @bind ) = @$$query;
    return $sql;
}
