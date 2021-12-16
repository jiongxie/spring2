/* 대(product1), 중(product2), 소분류 처리후, /상품명 등록처리 */
/* 상품 테이블 설정  */
create table dbProduct(
  idx  int not null auto_increment,  /* 상품 고유번호 */
  product3  varchar(50)  not null,    /* 소분류명 */
  product2  varchar(50)  not null,    /* 중분류명 */
  product1  varchar(50)  not null,    /* 대분류명 */
  product   varchar(50)  not null,    /* 상품명(상품코드-모델명) - (세)분류 */
  detail    varchar(100) not null,		/* 상품명에 따른 간단설명 : 이부분이 초기상품설명에 나온다. */
  mainprice int not null,							/* 상품의 기본가격 */
  fname     varchar(100)  not null,		/* 상품 기본 사진(1장은 필수) */
  rfname    varchar(100)  not null,  	/* 서버에 저장되는 실제 파일명 */
  content   text not null,						/* 상품의 상세설명 - 여기서는 한장의 사진으로 처리할것임 */
  primary key(idx, product)						/* 기본키(고유번호, 상품명) */
);
desc dbProduct;
delete * from dbProduct;
alter table dbProduct modify column fname varchar(100) not null;
alter table dbProduct modify column rfname varchar(100) not null;
update dbProduct set content=replace(content,'cjs200805/resources/ckeditor/images/','cjs200805/resources/ckeditor/images/study/');
select product3 from dbProduct group by product3 order by product3;
delete from dbProduct where product = '변동성돌파전략(후보군:ETF)';
--
--drop table dbProduct;
--drop table dbOption;
--drop table dbCartList;

select * from dbProduct order by idx desc;

/* 상품의 옵션 테이블 설정  */
create table dbOption (
  idx    int not null auto_increment,	/* 옵션 고유번호 */
  productIdx int not null,						/* 옵션을 포함하고 있는 product테이블의 고유번호(idx) */
  optionName varchar(50) not null,		/* 옵션 이름 */
  optionPrice int not null default 0, /* 상품 옵션 가격 */
  primary key(idx),										/* 기본키 : 고유번호 */
  foreign key(productIdx) references dbProduct(idx) on update cascade on delete cascade
);
desc dbOption;
delete from dbOption where optionName = '기본';
delete from dbOption;
select * from dbOption order by idx desc;
select * from dbOption where idx = 12;

/* 장바구니 테이블 */
create table dbCartList (
  idx   int not null auto_increment,
  cartDate datetime default now(),     	/* 장바구니에 상품을 담은 날짜 */
  mid   varchar(20) not null,
  productIdx int not null,								/* 상품 고유번호 */
  product    varchar(50) not null,			/* 상품명 */
  mainPrice int not null,								/* 메인 상품 가격 */
  thumbImg  varchar(50) not null,				/* 메일 이미지(서버에 저장된 이미지이름) */
  optionIdx varchar(50) not null, 			/* 옵션 고유번호 리스트(배열) */
  optionName varchar(100) not null,			/* 옵션명 리스트(배열) */
  optionPrice varchar(100) not null,		/* 옵션가격 리스트(배열) */
  optionNum		varchar(50)  not null, 		/* 옵션수량 리스트(배열) */
  totalPrice int not null,							/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
  primary key(idx, mid),
  foreign key(productIdx) references dbProduct(idx) on update cascade on delete cascade
);
desc dbCartList;
select * from dbCartList;

/* 주문 테이블 -  */
create table dbOrder (
  idx         int not null auto_increment, /* 고유번호 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호(새롭게 만들어 주어야 한다.) */
  mid         varchar(20) not null,   /* 주문자 ID */
  productIdx  int not null,           /* 상품 고유번호 */
  orderDate   datetime default now(), /* 실제 주문을 한 날짜 */
  product     varchar(50) not null,   /* 상품명 */
  mainPrice   int not null,				    /* 메인 상품 가격 */
  thumbImg    varchar(60) not null,   /* 썸네일(서버에 저장된 메인상품 이미지) */
  optionName  varchar(100) not null,  /* 옵션명    리스트 -배열로 넘어온다- */
  optionPrice varchar(100) not null,  /* 옵션가격  리스트 -배열로 넘어온다- */
  optionNum   varchar(50)  not null,  /* 옵션수량  리스트 -배열로 넘어온다- */
  totalPrice  int not null,					  /* 구매한 상품 항목(상품과 옵션포함)에 따른 총 가격 */
  /* cartIdx     int not null,	*/		/* 카트(장바구니)의 고유번호 */ 
  primary key(idx, orderIdx),
  foreign key(mid) references member2(mid),
  foreign key(productIdx) references dbProduct(idx)
);
drop table dbOrder;
desc dbOrder;
delete from dbOrder;
select * from dbOrder;

/* 배송테이블 */
create table dbBaesong (
  idx     int not null auto_increment,
  orderIdx    varchar(15) not null,   /* 주문 고유번호 */
  orderTotalPrice int     not null,   /* 주문한 모든 상품의 총 가격 */
  mid         varchar(20) not null,   /* 회원 아이디 */
  name				varchar(20) not null,   /* 배송지 받는사람 이름 */
  address     varchar(100) not null,  /* 배송지 (우편번호)주소 */
  tel					varchar(15),						/* 받는사람 전화번호 */
  message     varchar(100),						/* 배송시 요청사항 */
  payment			varchar(10)  not null,	/* 결재도구 */
  payMethod   varchar(50)  not null,  /* 결제도구에 따른 방법(카드번호) */
  orderStatus varchar(10)  not null default '결제완료', /* 주문순서(결제완료->배송중->배송완료->구매완료) */
  primary key(idx)
  /* foreign key(orderIdx) references dbOrder(orderIdx));
  on update cascade on delete cascade */
);
desc dbBaesong;
--drop table dbBaesong;
delete from dbBaesong;
select * from dbBaesong;
alter table dbBaesong add column orderStatus varchar(10)  not null default '결제완료';
alter table dbBaesong drop column orderStatus;
select a.name from dbBaesong a join dbOrder b using('202103102') where mid = 'admin' order by idx desc;
select a.name from dbBaesong a join dbOrder b using('2021020220') where mid = 'hkd1234';