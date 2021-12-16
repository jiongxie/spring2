create table community(
	idx int not null auto_increment,
	title varchar(20) not null,
	name varchar(20) not null,
	pwd int not null deault '1234',
	primary key(idx)
);
desc community;
select * from community;
insert into community values(default, "테슬라", "관리자");
delete from community where name="두더지";
select * from community where idx = 11;
alter table community add column password int not null default '1234';
alter table community add column pwd int not null default '1234';
alter table community drop column password;