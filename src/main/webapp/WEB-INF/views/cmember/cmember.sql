create table cmember(
	idx int not null auto_increment,
	mid varchar(20) not null,
	pwd int not null,
	primary key(idx)
);
desc cmember;
drop table cmember;
insert into cmember values(default, 'admin', '1234');
select * from cmember;