use utf8;

use open ':std', ':encoding(utf8)';
use Test::More;

use Postcodify;

my $p = Postcodify->new;

subtest '지번주소로 검색하는 경우' => sub {
    my $rs  = $p->search('서울시 광진구 화양동 48-3번지');
    my $sql = as_query($rs);
    like $sql, qr/JOIN `postcodify_keywords`/;
    like $sql, qr/crc32/;
    like $sql, qr/`me`.`num_major` =/;
    like $sql, qr/`me`.`num_minor` =/;

    $rs = $p->search(
        '48-3, Hwayang-dong, Gwangjin-gu, Seoul, 143-917 Rep. of KOREA');
    $sql = as_query($rs);
    like $sql, qr/LEFT JOIN `postcodify_english`/;
    like $sql, qr/en_crc32/;
    like $sql, qr/`me`.`num_major` =/;
    like $sql, qr/`me`.`num_minor` =/;
};

done_testing();

sub as_query {
    my $rs = shift;
    return unless $rs;

    my $query = $rs->as_query;
    my ( $sql, @bind ) = @$$query;
    return $sql;
}
