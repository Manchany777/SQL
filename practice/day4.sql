SELECT * FROM madang.book;
insert into book values(11, '스포츠 의학', '한솔의학서적', 10000);
insert into book (bookid, bookname, publisher) values(12, '스포츠 의학-2', '한솔의학서적');
insert into book (bookid, bookname, publisher) values(13, '스포츠 의학-3', '한솔의학서적');
insert into book (bookid, bookname, price) values(14, '스포츠 의학-4', '10000');
insert into book (bookid, bookname, price) values(14, '스포츠 의학-4', '10000');
insert into book (select * from imported_book);
insert into imported_book (bookname, publisher, price) select bookname, publisher, price from book where bookid not in (21,22);
insert into imported_book (bookname, publisher, price) values ('Zen Golf', 'Pearson', 12000);

update book set price = 10000 where price is null and bookid = 12;
set SQL_SAFE_UPDATES = 0; # disable safe mode; /* 특정 경우에만 Safe mode 를 off 하고 싶을 경우 */
update book set price = 10000 where price is null;
set SQL_SAFE_UPDATES = 1; # enable safe mode; /* 특정 경우에만 Safe mode 를 on 하고 싶을 경우 */

update book set publisher = '한솔의학서적' where publisher is null;
update book set publisher = '10000' where bookid = 12;
update book set publisher = '한솔의학서적' where publisher = '10000';
update book set publisher = (select publisher from imported_book where bookid = 21) where bookid = 14; 
update book set publisher = (select publisher from book where bookid = 21) where bookid = 15;

delete from imported_book where bookid between 21 and 39;

-- (1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select name from customer c, orders o, book b where c.custid = o.custid and o.bname = b.bookname and c.name != '박지성' and publisher in 
(select b.publisher from customer c1, orders o1, book b1 where c1.custid = o1.custid and o1.bname = b1.bookname and c1.name = '박지성') group by name;

select distinct name from customer c, orders o, book b where c.custid = o.custid and o.bookid = b.bookid and c.name != '박지성'and b.publisher in 
(select publisher from customer c1, orders o1, book b1 where c1.custid = o1.custid and o1.bookid = b1.bookid and c1.name = '박지성'); /*박지성이 구매한 출판사*/
select c.name, b.publisher from customer c, orders o, book b where c.custid = o.custid and o.bookid = b.bookid and c.name != '박지성'and b.publisher in 
(select publisher from customer c1, orders o1, book b1 where c1.custid = o1.custid and o1.bookid = b1.bookid and c1.name = '박지성');

-- (2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
select name from customer c1 where (select count(distinct publisher) from customer c, orders o, book b where c.custid = o.custid and o.bookid = b.bookid and c.name = c1.name)>=2;

-- (3) (생략 ) 전체 고객의 30% 이상이 구매한 도서
select bookid, count(custid)  as qty, (select count(*) from customer) as cnt, count(custid)/(select count(*) from customer)*100 as percentage from orders o group by bookid; 
/* having percentage >= 30;*/

-- (1) 새로운 도서 스포츠 세계’세계’, 대한미디어’대한미디어’, 10000 원 이 마당서점에 입고되었다 .삽입이안 될 경우 필요한 데이터가 더 있는지 찾아보자
insert into book (bookid, bookname, publisher, price) values(31, '스포츠 세계', '대한미디어', 10000);

-- (2) ‘삼성당’에서 출판한 도서를 삭제해야 한다
delete from book where publisher = '삼성당'

-- (3) ‘이상미디어’에서 출판한 도서를 삭제해야 한다 . 삭제가 안 될 경우 원인을 생각해보자
select * from orders o left join book b on o.bookid = b.bookid; 
delete from book where publisher = '이상미디어'

-- (4) 출판사 대한미디어’가 대한출판사’로 이름을 바꾸었다
update book set publisher = '대한출판사' where publisher = '대한미디어';


/* 내장 SQL */
-- 78 과 +78 의 절댓값을 구하시오
select abs(-78), abs(78) from dual;
-- 4.875 를 소수 첫째 자리까지 반올림한 값을 구하시오. round(숫자, 자리수)
select round(4.875, 1);
-- 고객별 평균 주문 금액을 백 원 단위로 반올림한 값을 구하시오
select custid, avg(saleprice), round(avg(saleprice), -2) from orders group by custid;
-- 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오
select bookid, replace(bookname,'야구', '농구') bookname, publisher, price from book;

select bookid, concat(bookname, ',', publisher) bookname, price from book;

/* 'aaa' =-> userid, '       aaa        ', trim('' from '     aaa      ') */
trim('=' from '=======aaa=======');
select length(trim('=' from '=======aaa======='));
select length('가나다');
select char_length('가나다 abc');

/* 날짜, 시간함수 */
select str_to_date('2022-10-17', '%Y-%m-%d');
select datediff('2022-10-29', '2022-10-17') +1; /* 오늘까지 포함하려면 +1 */
select sysdate();
select date_format(sysdate(), '%w번째 %W요일 %m-%M');
select sysdate(), adddate(sysdate(), interval 19 day);

/* 마당서점은 주문일로부터 10 일 후 매출을 확정한다 . 각 주문의 확정일자를 구하시오 */
select orderid '주문번호', orderdate '주문일자', adddate(orderdate, interval 10 day) '확정일자' from orders;





-- ----------------------------------------------------------------
SELECT count(*) FROM madang.mybook;
SELECT count(price) FROM madang.mybook;
select bookid, price, price+100 from mybook;
insert into oldbook values (null, null);

SELECT * FROM madang.oldbook;
insert into oldbook values (null, null);
delete from oldbook where bookid is null;
select count(*) from madang.oldbook;

-- 이름 , 전화번호가 포함된 고객목록을 보이시오 . 단 , 전화번호가 없는 고객은 ‘연락처없음’으로 표시한다
-- 책 정보를 출력하시오. 가격이 없으면 0으로 표시한다.
select bookname '책제목', ifnull(price, 0) '가격' from book;

-- 고객 목록에서 고객번호 , 이름 , 전화번호를 앞의 두 명만 보이시오 .
select custid, name, phone from customer limit 2; 
set @num := 0; /* null값 초기화를 위한 식 */
select (@num := @num + 1) '번호', custid, name, phone from customer limit 2;
select (@num := @num + 1) '번호', custid, name, phone from customer where @num < 12;
select (@num := @num + 1) '번호', custid, name, phone from customer;

-- newbook에서 bookid가 4보다 큰 책의 가격 총액과 평균과 책의 권수를 구하시오
select sum(price), avg(price), count(price) from mybook where bookid >= 4;
select custid, (select address from customer c where c.custid = o.custid) "address", sum(saleprice) "total" from orders o group by o.custid;
select c.name, s from (select custid, avg(saleprice) s from orders group by custid) o, customer c where c.custid = o.custid;
select sum(saleprice) "total" from orders o where exists (select * from customer c where custid <= 3 and c.custid = o.custid);

/* 뷰 생성 */
create view v_orders
as
select orderid, c.custid, name, b.bookid, bookname, saleprice, orderdate
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid;
