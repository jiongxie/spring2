/* ---- 대분류 ---- */
create table goods1(
  product1 varchar(50) not null primary key  /* 대분류명 */
);
/* drop table goods1; */
/* delete from goods1; */
insert into goods1 values ('매매');
insert into goods1 values ('조회');
insert into goods1 values ('기타');
select * from goods1;
/* ------ 중분류 ------ */
create table goods2 (
  product1 varchar(50) not null,   /* 대분류명 */
  product2 varchar(50) not null primary key,  /* 중분류명 */
  foreign key(product1) references goods1(product1)
  on update cascade
  on delete restrict
);
/* drop table goods */
/* delete from goods */
insert into goods2 value ('매매','매수');
insert into goods2 value ('매매','매도');
insert into goods2 value ('조회','잔고');
insert into goods2 value ('조회','주문');
insert into goods2 value ('기타','접속');
insert into goods2 value ('기타','전략');
insert into goods2 value ('기타','기타 알고리즘');
delete from goods2 where product2 = '기타전략';
select * from goods2;

/* ----------- 소분류 ------------- */
create table goods3 (
  idx      int not null auto_increment primary key,
  product1 varchar(50) not null,   						/* 대분류명 */
  product2 varchar(50) not null,  						/* 중분류명 */
  product3 varchar(50) not null,    					/* 소분류명 */
  foreign key(product1) references goods1(product1)
  on update cascade
  on delete restrict,
  foreign key(product2) references goods2(product2)
  on update cascade
  on delete restrict
);
/* drop table goods3 */
/* delete from goods3 */
insert into goods3 values (default,'매매','매수','가격변동');
insert into goods3 values (default,'매매','매수','거래량');
insert into goods3 values (default,'매매','매수','PER');
insert into goods3 values (default,'매매','매수','유먕종목');
insert into goods3 values (default,'매매','매수','분할매수');
insert into goods3 values (default,'매매','매도','손절매');
insert into goods3 values (default,'매매','매도','익절매');
insert into goods3 values (default,'매매','매도','분할매도');
insert into goods3 values (default,'매매','매도','일괄매도');
insert into goods3 values (default,'조회','잔고','결제잔고수량');
insert into goods3 values (default,'조회','잔고','평가금액');
insert into goods3 values (default,'조회','잔고','평가금액');
insert into goods3 values (default,'조회','잔고','평가손익');
insert into goods3 values (default,'조회','잔고','종목수');
insert into goods3 values (default,'조회','주문','100% 증거금 주문가능 금액');
insert into goods3 values (default,'조회','주문','종목별 주문비율');
insert into goods3 values (default,'조회','주문','종목별 주문 금액');
insert into goods3 values (default,'기타','접속','로그인');
insert into goods3 values (default,'기타','접속','로그아웃');
insert into goods3 values (default,'기타','접속','슬랙메신저');
insert into goods3 values (default,'기타','전략','이동평균선5일');
insert into goods3 values (default,'기타','전략','이동평균선10일');
insert into goods3 values (default,'기타','전략','변동성 돌파전략');
insert into goods3 values (default,'기타','전략','거래량 급등주 포착전략');
insert into goods3 values (default,'기타','전략','유망종목 매수전략');
insert into goods3 values (default,'기타','전략','저평가주 매수전략');
insert into goods3 values (default,'기타','기타 알고리즘','딥러닝 자동매매');
insert into goods3 values (default,'기타','기타 알고리즘','백테스트');
delete from goods3;
select * from goods3;
delete from goods3 where product3 = '손절매';
update goods3 set product3 = '분할매수(시간)' where product3 = '분할매수';
update goods3 set product3 = '분할매도(시간)' where product3 = '분할매도';
