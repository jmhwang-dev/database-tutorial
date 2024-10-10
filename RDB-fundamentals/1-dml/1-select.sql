select 고객아이디, 고객이름, 등급
from 고객;

select *
from 고객;

-- 투플의 중복을 허용. 기본적으로 중복을 허용하므로 필요하지 않음
select all 제조업체
from 제품;

-- 투플의 중복을 제거하고 한번씩만 출력
select distinct 제조업체
from 제품;

select 제품명, 단가 as 가격
from 제품;

select 제품명, 단가+500 as "조정 단가"
from 제품;

select 제품명, 재고량, 단가
from 제품
where 제조업체='한빛제과';

select 주문제품, 수량, 주문일자
from 주문
where 주문고객='apple' and 수량 >=15;




-- %: 0개 이상의 문자 (문자의 내용과 개수는 상관 없음)
-- _: 1개의 문자(문자의 내용과 상관 없음)
select 고객이름, 나이, 등급, 적립금
from 고객
where 고객이름 like '김%';


-- null은 반드시 is null 키워드로 표현해야한다.
-- not의 경우 is not null 로 표현한다.
-- null은 다른 값과 크기를 비교하면 결과가 모두 거짓이 된다.
select 고객이름
from 고객
where 나이 is null;


-- order by 의 디폴트: asc
select 고객이름, 등급, 나이
from 고객
order by 나이 desc;


select 주문고객, 주문제품, 수량, 주문일자
from 주문
where 수량 >= 10
order by 주문제품 asc, 수량 desc;


-- 집계함수: 열 함수라고도 함.
-- 모든 데이터에 가능
--  개수: count, 최대값: max, 최솟값: min
-- 숫자 데이터에 가능
--   합계: sum, 평균: avg

-- 집계함수는 null 속성 값 제외하고 계산한다.
-- 집계함수는 select 절, having 절에서만 사용할 수 있다. (where 절은 사용할 수 없다.)

select sum(재고량) as "재고량 합계"
from 제품
where 제조업체 = '한빛제과';


--- null은 count에 포함되지 않는 예시
select count(고객아이디) as "고객아이디 개수", count(나이) as "고객나이 개수"
from 고객;

-- * : 모든 속성을 의미하는 기호
select count(*)
from 고객;

-- 중복값 제거 전 개수 출력
select count(제조업체) as "제조업체 수"
from 제품;
-- 중복값 제거 후 개수 출력
select count(distinct(제조업체)) as "제조업체 수"
from 제품;



-- 그룹별 검색: 특정 속성의 값이 같은 투플을 모아 그룹을 만들고, 그룹별로 검색을 하기 위함
-- 그룹을 나누는 속성을 select 절에 작성하는 것이 좋다. 실행은 되지만 어떤 그룹에 대한 검색 결과인지를 확인하기 어렵기 때문
select 주문제품, sum(수량) as "총주문수량"
from 주문
group by 주문제품
order by 주문제품;


select 제조업체, count(제품번호) as "제품수", max(단가) as "최고가"
from 제품
group by 제조업체
order by 제조업체;

-- 그룹에 대한 조건은 having 절에 작성한다.
select 제조업체, count(*) as "제품수", max(단가) as "최고가"
from 제품
group by 제조업체 having count(*) >= 3;


select 등급, count(고객아이디) as "고객수", avg(적립금) as "평균적립금"
from 고객
group by 등급 having avg(적립금) >= 1000;


-- 그룹별로 검색할 때 사용할 수 있는 속성
--  집계 함수, group by 절에 있는 속성
select 주문제품, 주문고객, sum(수량) as "총주문수량"
from 주문
group by 주문제품, 주문고객;


-- join
-- 판매 데이터베이스에서 banana 고객이 주문한 제품의 이름을 검색해보자.
select 제품.제품명
from 제품, 주문
where 제품.제품번호 = 주문.주문제품 and 주문.주문고객 = 'banana';

-- 판매 데이터베이스에서 나이가 30세 이상인 고객이 주문한 제품의 번호와 주문일자를 검색
select 주문.주문제품, 주문.주문일자
from 고객, 주문
where 고객.나이 >= 30 and 고객.고객아이디 = 주문.주문고객;


-- 조인 시, 테이블에 별명 붙이기
select o.주문제품, o.주문일자
from 고객 c, 주문 o
where c.나이 >= 30 and c.고객아이디 = o.주문고객;


-- 따옴표 주의
select p.제품명
from 고객 c, 제품 p, 주문 o
where c.고객아이디 = o.주문고객
and o.주문제품 = p.제품번호
and c.고객이름 = '고명석';



-- 표준은 아래와 같다.
-- 나이가 30세 이상인 고객이 주문한 제품의 주문제품과 주문일자
select 주문.주문제품, 주문.주문일자
from 고객 inner join 주문 on 고객.고객아이디 = 주문.주문고객
where 고객.나이 >= 30;


-- 위 내용은 동등 조인. 그 외 조인은 아래와 같다.
-- SELECT 속성_리스트
-- FROM 테이블1 LEFT | RIGHT | FULL OUTER JOIN 테이블2 ON 조인조건 
--  [ WHERE 검색조건 ] 