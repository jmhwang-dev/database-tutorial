update 제품
set 제품명='통큰파이'
where 제품번호='p03';

-- 산술식을 사용해 수정할 속석 값을 제시할 수도 있다.
update 제품
set 단갸=단가 * 1.1;

update 주문
set 수량=5
where 주문고객 in (
    select 고객아이디
    from 고객
    where 고객이름='정소화'
);