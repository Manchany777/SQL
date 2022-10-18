SELECT * FROM madang.sales;
use madang;

/* 매출테이블에서 각 브랜드별 제품 판매가 각 브랜드별 평균판매보다 높은 매출을 구하시오 */
select brand, avg(amount) from sales group by brand;
select brand, avg(amount) from sales where brand = '나이키'; /* so, 하나씩 서브쿼리로 비교하는 상관 서브쿼리에서는 굳이 group by가 필요없다 */
select * from sales where brand = '나이키' and amount > 143000; /* 나이키, avg(amount) */
select * from sales where brand = 'MLB' and amount > 243000; /* MLB, avg(amount) */
select brand, amount from sales s1 where s1.amount > (select avg(amount) from sales s2 where s2.brand = s1.brand);  /* 위 아래 같은 거 */
select s1.brand, amount from sales s1 where s1.amount > (select avg(s2.amount) from sales s2 where s2.brand = s1.brand); 
select b1.bookname from Book b1 where b1.price > (select avg(b2.price) from Book b2 where b2.publisher=b1.publisher);	

/* 각 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오 */
select avg(price) from book where price > 7000 and publisher = '굿스포츠';
select bookname from book b1 where b1.price > (select avg(price) from book b2 where b2.publisher = b1.publisher);

/* 각 부서별로 해당부서의 평균 연봉보다 연봉이 높은 직원의 내역을 출력하라 */
select d1.empcode from dept_map d1 where d1.salary > (select avg(d2.salary) from dept_map d2 where d1.deptcode = d2.deptcode);
select * from dept_map d1 inner join dept_map d2 on d1.deptcode = d2.deptcode group by dept_map having d1.salary > avg(d2.salary);

/* (13)도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름 */  
select o1.custid, avg(saleprice) from orders o1 inner join customer c on o1.custid = c.custid
group by o1.custid having avg(saleprice) > (select avg(saleprice) from orders);


/* scalar subquery */
select (select name from customer c where c.custid = o.custid) as custname, sum(saleprice) as total from orders o group by o.custid;
select (select name from customer c where c.custid = o.custid) "custname", sum(saleprice) "total" from orders o group by o.custid;

/* inline view */
/* 질의 4-14 고객번호가 2 이하인 고객의 판매액을 보이시오 (고객이름과 고객별 판매액 출력) */
select o.custid, sum(saleprice) from orders o, (select * from customer c where custid <=2) c where o.custid = c.custid group by o.custid;
select o.custid, sum(saleprice) from orders o, customer c  where o.custid = c.custid and c.custid <= 2 group by o.custid;

/* 질의 4 15 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오*/
select orderid, saleprice from orders where saleprice <= (select avg(saleprice) from orders);

/* 질의 4 16 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호 , 고객번호 , 금액을 보이시오*/
select orderid, custid, saleprice from orders o1 where saleprice > (select avg(saleprice) from orders o2 where o1.custid = o2.custid);

/* 질의 4-17 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오 */
select sum(saleprice) from orders where custid in (select custid from customer where address like '대한민국%')

