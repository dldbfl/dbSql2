-- OUTER join : 조인 연결에 실패 하더라도 기준이 되는 테이블의 데이터는
-- 나오도록 하는 join
-- LEFT OUTER JOIN : 테이블1 LEFT OUTER JOIN 테이블2
-- 테이블 1과 테이블2 를 조인할때, 조인에 실패하더라도 테이블1쪽에 데이터는 조회가 되도록하오.
-- 조인에 실패한 행에서 테이블2의 컬럼값은 존재하지 않으므로 NULL로 표시되오.

SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename,e.DEPTNO ,m.empno, m.ename , m.DEPTNo
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10);

SELECT e.empno, e.ename,e.DEPTNO ,m.empno, m.ename , m.DEPTNo
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno 
WHERE m.deptno = 10;


--ansi
-- 직원 LEFT OUTER JOIN 매니저
--ON (직원.매니저번호 = 매니저.직원번호)

SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
--oracle
--일반조인과 차이점은 컬럼명에 (+)표시
--(+)표시 : 데이터가 존재하지 않는데 나와야 하는 테이블의 컬럼
-- 직원 LEFT OUTER JOIN 매니저
--ON (직원.매니저번호 = 매니저.직원번호) -- 매니저 쪽 데이터가 존재하지 않음
SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e , emp m 
WHERE e.mgr   = m.empno(+);

--매니저 부서번호 제한
--*아우터 조인이 적용되어야 하는 모든 컬럼에 (+)가 붙어야 된다.
SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e , emp m 
WHERE e.mgr   = m.empno(+)
AND m.DEPTNO (+)= 10;

--emp 테이블에는 14명의 직원이 있고 14명은 10, 20 ,30부서중에 한 부서에 속한다.
--하지만 dept테이블에는 10, 20 ,30 , 40번 부서가 존재
--부서번호, 부서명, 해당부서에 속한 직원수가 나오도록 쿼리를 작성
select * from dept;
select * from emp;

SELECT dept.deptno, dname, count(empno)
FROM emp, dept
WHERE emp.deptno (+)= dept.deptno 
GROUP BY dept.deptno, dname
ORDER BY dept.deptno;

--dept : deptno, dname
--inlin : deptno, cnt(직원의 수)
SELECT dept.deptno, dept.dname,NVL(emp_cnt.cnt,0)cnt
FROM dept,
(SELECT emp.deptno, count(*) cnt
FROM emp
GROUP BY deptno)emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);

SELECT dept.deptno, dept.dname,NVL(emp_cnt.cnt,0)cnt
FROM dept LEFT OUTER JOIN (SELECT emp.deptno, count(*) cnt
                            FROM emp
                            GROUP BY deptno)emp_cnt
                        ON dept.deptno = emp_cnt.deptno(+);

-- RIGHT OUTER JOIN
 
SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER - 중복데이터 한건만 남기기
SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

--outerjoiun1
SELECT * FROM buyprod;
SELECT * FROM prod;

SELECT TO_CHAR(buy_date,'YY/MM/DD')buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod, prod
WHERE buy_prod (+)= prod_id
AND buy_date(+) = to_date('20050125');

--outerjoin2

SELECT NVL(TO_CHAR(buy_date,'YY/MM/DD'),TO_CHAR(to_date('20051025','yyyymmdd'),'YY/MM/DD')) buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod, prod
WHERE buy_prod (+)= prod_id
AND buy_date(+) = to_date('2005/01/25');

--outerjoin3

SELECT NVL(buy_date,TO_CHAR(TO_DATE('20050125'),'YY/MM/DD')) buy_date, buy_prod, prod_id, prod_name, 
        NVL(buy_qty,0) buy_qty 
FROM buyprod, prod
WHERE buy_prod (+)= prod_id
AND buy_date(+) = to_date('2005/01/25');

--outerjoin4
SELECT * FROM cycle;
SELECT * FROM product;

SELECT nvl(cycle.PID,product.pid)pid, PNM, nvl(CID,1)cid,nvl(DAY,0)day, nvl(CNT,0)cnt
FROM cycle, product
WHERE cycle.pid (+)= product.pid 
AND cid (+)= 1;

--outerjoin 5
SELECT * FROM cycle;
SELECT * FROM product;
SELECT * FROM customer;

SELECT cycle.PID, PNM, customer.CID, customer.cnm,day, cnt
FROM cycle, product, customer
WHERE cycle.pid= product.pid 
AND customer.cid = 1
AND cycle.cid  = customer.cid ;
ORDER BY cycle.pid DESC;