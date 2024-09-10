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