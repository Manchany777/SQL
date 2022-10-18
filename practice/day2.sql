use madang;
show tables;
desc book;
select bookname, publisher from book;
desc customer;
select * from customer;
/*  축구의 역사 라는 도서의 출판사와 가격을 알고 싶다. */
select bookname, publisher, price from book where bookname like '%축구%';
/*  책의 가격이 15000 원 이상인 도서의 이름과 출판사와 가격을 알고 싶다. */
select bookname, publisher, price from book where price >= 15000 order by price desc;
select bookname, publisher, price from book where price between 10000 and 20000;
/* 김연아 고객의 전화번호를 가져오시오 */
select phone from customer where name='김연아';

select * from book order by bookname;
select distinct publisher from book;
/* 출판사가 나무수 이거나 이상미디어 인 책의 이름과 가격을 가져오시오 , in 이나 or 두 가지 다 작성해보시오.*/
select bookname, price , publisher from book where publisher in ( '나무수', '이상미디어' ) ;
select bookname, price, publisher from book where (publisher='나무수' )  or ( publisher= '이상미디어' );

select * from book ;
select bookname, price , publisher from book where publisher not in ( '굿스포츠', '대한미디어' ) ;
select bookname, price, publisher from book where (publisher <> '굿스포츠' )  and ( publisher <> '대한미디어' );

select * from book where bookname like '[0-5]%';
/* 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오. */
select * from book where price >= 20000 and bookname like '%축구%';
/* 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름
차순으로 검색한다.*/
select *
from book 
order by  price desc, publisher;

/*고객이 주문한 도서의 총 판매액을 구하시오.*/
desc orders;
select SUM(saleprice) as Total from orders;
/* 총 고객의 수를 구하시오 , field 이름으로 count 주의사항 ==> 값이 null 이면 count 가 안됨 */
select count(*) from customer;
select count(*) as 'all' , count(phone) as CNT from customer;
/* 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오. */
select sum(saleprice) as total
from orders
where custid=2;
/* 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오. */
select 
sum(saleprice) as Total, 
avg(saleprice) as Average, 
min(saleprice) as Minimum , 
max(saleprice) as Maximum 
from orders
where sum(saleprice) = 118000;
/*고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오. 단, 3권을 구매한 주문 정보만 가져오시오. */
/*고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오. 단, 3만원 이상 구매한 주문 정보만 가져오시오. */
select 
	custid,  
	count(*) as '총수량' ,
    sum(saleprice) as Total
from orders
group by custid
having count(*) = 3;

select 
	custid,  
	count(*) as '총수량' ,
    sum(saleprice) as Total
from orders
group by custid
having Total >= 30000;

/* 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
 단, 두 권 이상 구매한 고객만 구한다.
 Error Code: 1054. Unknown column 'salesprice' in 'where clause'

 */
 select 
	custid,
	count(*) as '도서수량'
 from orders
 where saleprice >= 8000
 group by custid 
 having 도서수량 >= 2;


/* 연습문제 3-49 */
select bookname from book where bookid =1;
select bookname from book where price >= 20000;
select sum(saleprice) from orders where custid = 1;
select count(*) from orders where custid =1;

select count(*) from book;
select distinct publisher from book;
select count(distinct publisher) from book;
select name, address from customer;
select orderid, orderdate from orders where orderdate between '20140704' and '20140707';
select orderid from orders where orderdate not in ('20140704', '20140707');
select orderid, orderdate from orders where (orderdate < '20140704') or (orderdate > '20140707');
select name, address from customer where name like '김%';
select name, address from customer where name like '김%아';
select name, address from customer where name like '김%' or '%아';
/* ------------- 조인 ------------- */
select * 
from customer, orders 
where customer.custid = orders.custid 
  and customer.name = '박지성' ;
/*고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오.*/
select * from customer c, orders o where c.custid = o.custid order by c.custid;
/* 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오. */
select name, saleprice from customer c, orders o where c.custid = o.custid;
/* 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오. */
select name, sum(saleprice) as '총 판매액' from customer c, orders o where c.custid = o.custid group by name order by name;
/* 고객의 이름과 고객이 주문한 도서의 이름을 구하시오. */
select name, bookname from book b, customer c, orders o where b.bookid = o.bookid and c.custid = o.custid;
/* 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오. */
select name, bookname, price, c.custid from book b, customer c, orders o where b.bookid = o.bookid and c.custid = o.custid and b.price >= 20000;

/* 고객의 이름과 고객이 주문한 도서의 이름을 구하시오. (inner join으로 구하라) */
select name, bookname from book b, customer c, orders o where b.bookid = o.bookid and c.custid = o.custid;
select name, bookname from orders o inner join customer c on c.custid = o.custid inner join book b on o.bookid = b.bookid order by name; 
select name, bookname from orders o inner join customer c inner join book b on c.custid = o.custid and o.bookid = b.bookid order by name; 




use employees;
select count(*) from departments;
select count(*) from dept_emp;
select count(*) from dept_manager;
select count(*) from employees;
select count(*) from salaries;
select count(*) from titles;

select * from departments d, dept_emp e where d.dept_no = e.dept_no;
select * from departments d inner join dept_emp e on d.dept_no = e.dept_no;
use madang;

select * from customer c 
left join orders o on c.custid = o.custid
where o.custid is null;
select * from orders o right join book b on o.bookid = b.bookid where o.bookid is null;
/* 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오. */
select name, saleprice from customer c left outer join orders o on c.custid = o.custid;

/* 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오. 1. 김연아, 장미란, 박세리 2. 김연아, 장미란, 박지성, 추신수 */
select name, address from customer where address like '대한민국%'
union
select name, address from customer where custid in (1,2,3,4);
select name, address from customer where address like '대한민국%'      /* 위에 거랑 같은거 */
union
select name, address from customer c, orders o where c.custid = o.custid;

/* 서브쿼리 */
select max(price) from book; /* 1번 */
select * from book where price = 35000; /* 2번(1번 값을 바탕으로 한) */
select * from book where price = (select max(price) from book); /* 1번+2번 */
select * from book where price in (select max(price) from book);  /* in은 뭐임??? */

select min(price) from book;
select * from book where price = 6000;
select * from book where price = (select min(price) from book);
/* 도서를 구매한 적이 있는 고객의 이름을 검색하시오. */
select name from customer where custid in (select distinct custid from orders);

/* (5) 박지성이 구매한 도서의 출판사 수 */  
select count(distinct publisher) as '출판사 개수' from customer c inner join book b inner join orders o on c.custid = o.custid and o.bookid = b.bookid where c.name = '박지성';
/* (6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이 */
select bookname, price, saleprice, (price - saleprice) as difference from customer c inner join orders o inner join book b on c.custid = o.custid and o.bookid = b.bookid where c.name = '박지성';
/* (7) 박지성이 구매하지 않은 도서의 이름???????? */
select distinct bookname from customer c inner join orders o inner join book b on; /* 내가 하던 것 */

select distinct bookname from customer c inner join orders o on c.custid = o.custid inner join book b on o.bookid = b.bookid where c.name <> '박지성'  /* where c.name <> '박지성' = where c.name in ('김연아', '장미란', '추신수') */
union select bookname from orders o right join book b on o.bookid = b.bookid where o.bookid is null; /* 아무도 팔리지 않은 책까지 union으로 묶어줌 */

-- (8) 주문하지 않은 고객의 이름(부속질의 사용)
select name from customer c where custid not in (select distinct custid from orders);
-- (9) 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice) as '총액', avg(saleprice) as '평균 금액' from orders;
-- (10) 고객의 이름과 고객별 구매액
select name, sum(saleprice) from customer c inner join orders o on c.custid = o.custid group by name;
-- (11) 고객의 이름과 고객이 구매한 도서 목록
select name, bookname from customer c inner join orders o on c.custid = o.custid inner join book b on b.bookid = o.bookid;
-- (12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select max(price - saleprice) as diff from book b inner join orders o on b.bookid = o.bookid ;

select *, (price - saleprice) as diff from orders o inner join book b on b.bookid = o.bookid where (price - saleprice) = (select max(price - saleprice) as diff from book b inner join orders o on b.bookid = o.bookid);
-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름

/* 대한민국에서 거주하는 고객의 이름에서 도서를 주문한 고객의 이름 빼고 보이시오 */ 
select name from customer c left join orders o on c.custid = o.custid where address like '대한민국%' and o.custid is null;
select name from customer where address like '대한민국%' and custid not in (select distinct custid from orders);
select name from customer c where address like '대한민국%' and c.custid not in (select c.custid from orders o where o.custid = c.custid); /* 상관 서브쿼리로 변환한 것 */

/* 질의 3-33 주문이 하나라도 있는 고객의 이름과 주소를 보이시오. */
select name, address from customer c where exists (select * from orders o where c.custid = o.custid);
select name, address from customer c where c.custid in (select custid from orders o);
select distinctname, address from customer c inner join orders o on c.custid = o.custid;

select * from book where price > (select avg(price) from book);
/* 책이 판매된 적이 있으면 = any */
select * from book where bookid = any (select distinct bookid from orders);
