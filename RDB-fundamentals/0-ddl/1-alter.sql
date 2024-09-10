alter table 고객 add 가입날짜 date;
alter table 고객 drop column 가입날짜 date;

alter table 고객 add constraint chk_age check(나이 >= 20);
alter table 고객 drop constraint chk_age;


-- alter table 주문 add constraint 주문고객 foreign key(주문고객) references 고객(고객아이디);