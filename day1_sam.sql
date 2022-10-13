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



