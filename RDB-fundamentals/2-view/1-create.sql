-- with check option: 생성한 뷰에 삽입이나 수정 연산을 할 때 select 문에서 where 키워드와 함께 제시한 뷰의 정의 조건을 위반하면 수행되지 않도록 하는 제약조건을 의미한다.
create view 우수고객(고객아이디, 고객이름, 나이, 등급)
as
select 고객아이디, 고객이름, 나이, 등급
from 고객
where 등급='vip'
with check option;


-- 속성을 생략할 수 있다. 생략하면, select 절에 나열된 속성의 이름을 뷰에서도 그대로 사용한다.
create view 우수고객
as
select 고객아이디, 고객이름, 나이, 등급
from 고객
where 등급='vip'
with check option;

-- create view 문에서는 뷰를 구성하는 속성의 이름을 생략하면 기본 테이블 조회 결과의 속성으로 구성된다.
-- 뷰를 구성하는 속성의 이름을 명확히 제시해야한다.
create view 업체별제품수(제조업체, 제품수)
as
select 제조업체, count(*) from 제품 group by 제조업체;