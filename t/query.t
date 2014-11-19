use utf8;

use open ':std', ':encoding(utf8)';
use Test::More;

use Postcodify::Query;

my $q = Postcodify::Query->new;

like( $q->parse('서울,광진구'), qr/서울특별시 광진구/, '검색어에서 불필요한 문자를 제거한다' );
like( $q->parse('00번지 0호'), qr/00-0/, '지번을 00번지 0호로 쓴 경우 검색 가능한 형태로 변환한다' );
like( $q->parse('화양 3동'), qr/화양3동/, '행정동, 도로명 등의 숫자 앞에 공백에 있는 경우 붙여쓴다' );
like( $q->parse('Achasan-ro, Gwangjin-gu, Seoul'), qr/Achasan-ro Gwangjin-gu Seoul/, '영문 도로명주소 또는 지번주소인지 확인한다' );
like( $q->parse('Nonsan P.O.Box, Nonsan-si, Chungcheongnam-do, Korea'), qr/Nonsan P.O.Box Nonsan-si Chungcheongnam-do Korea/, '영문 사서함 주소인지 확인한다' );
unlike( $q->parse('산'), qr//, '키워드가 "산", "지하", 한글 1글자인 경우 건너뛴다' );
unlike( $q->parse('지하'), qr//, '키워드가 "산", "지하", 한글 1글자인 경우 건너뛴다' );
like( $q->parse('웅진빌딩 403호'), qr//, '이미 건물명이 나온 경우 건물명만 계속 검색한다' );
like( $q->parse('충남 서산시 고북면'), qr/충남 서산시 고북면/, '시군구읍면을 확인한다' );
like( $q->parse('아차산로'), qr/아차산로/, '도로명+건물번호를 확인한다' );
is( $q->parse('아차산로')->sort, 'JUSO', '도로명+건물번호를 확인한다' );
like( $q->parse('화양3동 48-3번지'), qr/화양3동 48-3번지/, '동리+지번을 확인한다' );
like( $q->parse('사서함 400호'), qr/사서함 400호/, '사서함을 확인한다' );
is( $q->parse('사서함 400호')->sort, 'POBOX', '사서함을 확인한다' );
like( $q->parse('48 - 3번지'), qr//, '건물번호, 지번, 사서함 번호를 따로 적은 경우를 확인한다' );
unlike( $q->parse('101동'), qr/101동/, '그 밖의 키워드는 건물명으로 취급하되, 동·층·호수는 취급하지 않는다' );
like( $q->parse('호잇~'), qr//, '그 밖의 키워드가 나오면 그만둔다' );
done_testing();
