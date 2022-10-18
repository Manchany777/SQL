SELECT * FROM madang.book;
show variables like 'datadir';
create index idx_name on customer (name asc);
show index from book;
select * from customer where name = '박지성';
select * from book where bookname like '축구의 이해';
create index book_name on book (bookname asc);
create index inx_publisher on book (publisher desc);
show index from book;

grant all privileges on madang.* to root@localhost with grant option;