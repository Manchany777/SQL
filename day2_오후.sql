use madang;
SELECT * FROM madang.book;
select * from customer c
left join orders o 
on c.custid = o.custid
where o.custid is null ; 

select * from orders o 
right join book b 
on o.bookid = b.bookid
where o.bookid is null;

select * from orders o   
right join customer c
on c.custid = o.custid ;
/*right join book b
on o.bookid = b.bookid; */
/*where o.custid is null; Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 4
*/

/*질의 3-32   대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오. 
김연아, 장미란, 박세리
박지성, 김연아, 장미란, 추신수
Error Code: 1222. The used SELECT statements have a different number of columns
*/
select name , address
from customer
where address like '대한민국%'
union
select name , address
from customer 
where custid in (1,2,3,4);

select max(price)
from book;

select * from book
where price = 35000;

select * from book
where price = (select max(price) from book) ;

select * from book
where price = (select min(price) from book) ;
/* 질의 3-29   도서를 구매한 적이 있는 고객의 이름을 검색하시오.*/
select name 
from customer
where custid in (1,2,3,4);
select distinct custid from orders;
select name 
from customer
where custid in (select distinct custid from orders);
/* 박지성이 구매한 도서의 출판사 수 */
select *
from customer c inner join orders o 
on c.custid = o.custid 
where c.name = '박지성';

select count(distinct publisher) as '출판사 갯수'
from customer c 
inner join orders o 
inner join book b
on c.custid = o.custid and o.bookid = b.bookid
where c.name = '박지성';

select distinct publisher as '출판사 갯수'
from customer c 
inner join orders o 
inner join book b
on c.custid = o.custid and o.bookid = b.bookid
where c.name = '박지성';

/* (6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이 */
select bookname, price , saleprice, (price - saleprice) as difference 
from customer c 
inner join orders o 
inner join book b
on c.custid = o.custid and o.bookid = b.bookid
where c.name = '박지성';

/* (7) 박지성이 구매하지 않은 도서의 이름 */
select * from orders o inner join customer c 
on c.custid = o.custid 
where c.name <> '박지성' ;

select distinct bookname 
from customer c 
inner join orders o 
on c.custid = o.custid 
inner join book b
on o.bookid = b.bookid
where c.name <> '박지성'
union
select bookname 
from orders o
right join book b
on o.bookid = b.bookid
where o.bookid is null ;


select distinct bookname 
from customer c 
inner join orders o 
on c.custid = o.custid 
inner join book b
on o.bookid = b.bookid
where c.name <> '박지성';

select bookname 
from orders o
right join book b
on o.bookid = b.bookid
where o.bookid is null;

/*(8) 주문하지 않은 고객의 이름(부속질의 사용)*/
select name 
from customer 
where custid not in (select distinct custid from orders);
/*(9) 주문 금액의 총액과 주문의 평균 금액 */
select sum(saleprice) as total , 
avg(salepric) as average
from orders;
/*(10) 고객의 이름과 고객별 구매액 */
select name , sum(saleprice)
from customer c inner join orders o 
on c.custid = o.custid 
group by name;
/* (11) 고객의 이름과 고객이 구매한 도서 목록 */
select name , bookname 
from customer c inner join orders o 
on c.custid = o.custid 
inner join book b
on b.bookid = o.bookid;
/*(12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문 */
select max(price - saleprice) as diff from book b 
inner join orders o 
on b.bookid = o.bookid ; /* 서브쿼리 */

select orderid, bookname, price, saleprice , (price - saleprice) as diff  from orders o
inner join book b 
on b.bookid = o.bookid 
where  (price - saleprice)  = (select max(price - saleprice) from book b 
				inner join orders o 
on b.bookid = o.bookid) ; /* 서브쿼리 사용한 결과 */
/*(13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름 */
