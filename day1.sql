desc orders;
/* 고객이 주문한 도서의 총 판매액을 구하시오 */
select sum(saleprice) as Total from orders;
/* 총 고객의 수를 구하시오, customerfield 이름으로 count 주의사항 ==> 값이 null이면 count가 안됨 */
select count(*) from customer;
select count(phone) from customer;
/* 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오 */
select sum(saleprice) from orders where custid=2;
/* 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오. */
select sum(saleprice), avg(saleprice), max(saleprice), min(saleprice) from orders; 
/* 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오. */
select custid, count(*) as '총 수량', sum(saleprice) as '총 판매액' from orders group by custid;
/* 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오. 단, 3권을 구매한 고객 정보만 가져오시오. */
select custid, count(*) as '총 수량', sum(saleprice) as '총 판매액' from orders group by custid having count(*) = 3;
/* 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오. 단, 3만원 이상 주문한 고객 정보만 가져오시오. */
select custid, count(*) as '총 수량', sum(saleprice) as '총 판매액' from orders group by custid having saleprice >= 30000;
/* 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총수량을 구하시오. 단, 두 권 이상 구매한 고객만 구한다. */
select custid, count(*) as '총수량', sum(saleprice) from orders where saleprice >= 8000 group by custid having count(*) >=2 order by custid;