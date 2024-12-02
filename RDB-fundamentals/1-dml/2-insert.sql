insert
into 고객(고객아이디, 고객이름, 나이, 등급, 직업, 적립금)
values ('strawberry', '최유경', 30, 'vip', '공무원', 100);


-- 고객 테이블의 속성 순서와 같으므로 into 절의 속성 이름을 다음과 같이 생략 가능
insert
into 고객
values ('strawberry', '최유경', 30, 'vip', '공무원', 100);

-- p.243
insert
into 고객(고객아이디, 고객이름, 나이, 등급, 적립금)
values ('tomato', '정은심', 36, 'gold', 4000);

-- NULL 값을 직접 제시해도 결과는 동일하다.
insert
into 고객
values ('tomato', '정은심', 36, 'gold', NULL, 4000);

-- 부속 질의문을 이용한 데이터 삽입 
create table 한빛제품(
    제품명 varchar(10),
    재고량 int,
    단가 int
);

insert
into 한빛제품(제품명, 재고량, 단가)
select 제품명, 재고량, 단가
from 제품
where 제조업체 = '한빛제과';

drop table 한빛제품;