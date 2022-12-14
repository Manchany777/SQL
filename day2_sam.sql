SELECT * FROM madang.book;
/* 1)도서번호가 1인 도서의 이름
   2)가격이 20,000원 이상인 도서의 이름
  (3) 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
  (4) 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성) */
use madang;
select bookname from book where bookid = 1;
select bookname from book where price >= 20000;
select sum(saleprice) 
from orders
where custid = 1;

select count(*) 
from orders
where custid = 1;

/*(1) 마당서점 도서의 총 개수
(2) 마당서점에 도서를 출고하는 출판사의 총 개수
(3) 모든 고객의 이름, 주소
(4) 2014년 7월 4일~7월 7일 사이에 주문 받은 도서의 주문번호
(5) 2014년 7월 4일~7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호*/
select count(*) from book;
select distinct publisher from book;
select count(distinct publisher) from book;
select name, address from customer;
select orderid, orderdate 
from orders 
where orderdate between '20140704' and '20140707' ;
select orderid, orderdate
from orders
where orderdate < '20140704' or orderdate > '20140707';
/*(6) 성이 ‘김’ 씨인 고객의 이름과 주소
(7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소*/
select name, address 
from customer
where name like '김%';
select name, address 
from customer
where name like '김%아';

/* 조인  Error Code: 1052. Column 'custid' in where clause is ambiguous
 */
select * 
from customer, orders 
where customer.custid = orders.custid 
  and customer.name = '박지성' ;







