delete
from 주문
where 주문일자='2022-05-22';

delete                                                                                      
from 주문
where 주문고객 in (
    select 고객아이디
    from 고객
    where 고객이름='정소화'
);