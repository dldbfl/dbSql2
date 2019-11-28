
--join     a.c = b.c c로 연결된 a,b 두가지의 혼종. 
--emp 테이블, dept 테이블 조인

EXPLAIN PLAN FOR
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT ename, deptno 
FROM emp;

SELECT deptno, dname 
FROM dept;

SELECT *
FROM TABLE (DBMS_XPLAN.DISPLAY);
-- "안쪽에서부터 읽고, 위에서 부터 읽는다.( 밑에꺼 번호 2-3-1-0순으로 읽음) 2,3은 동일 선상의 1번의 자식 오퍼레이션


SELECT ename, emp.deptno, dept.dname
FROM emp,dept
WHERE emp.deptno != dept.deptno
AND emp.deptno=10;

--natural join : 조인테이블간 같은 타입, 같은 이름의 컬럼으로
--               같은 값을 갖을 경우 조인

--ANSI SQL
SELECT deptno , emp.empno, ename
FROM emp NATURAL JOIN dept;

--oracle 문법
SELECT emp.deptno, emp.empno, ename
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--JOIN USING
--join 하려고 하는 테이블 간 동일한 이름의 컬럼이 두개 이상일 떄
--join 컬럼을 하나만 사용하고 싶을 때

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);
--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--ANSI JOIN with ON 
--조인 하고자 하는 테이블의 컬럼 이름이 다를 때
--개발자가 조인 조건을 직접 제어할 때
--ANSI sql
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);
--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간 조인
--emp 테이블간 조인 할만한 사항 : 직원의 관리자 정보 조회
--직원의 관리자 정보를 조회
--직원 이름, 관리자 이름
--직원 이름, 직원의 상급자 이름, 직원의 상급자 이름

--ANSI sql
SELECT e.ename, m.ename, u.ename, q.ename
FROM emp e JOIN emp m ON e.mgr = m.empno JOIN emp u ON m.mgr = u.empno JOIN emp q ON u.mgr = q.empno;
--ORACLE SQL
SELECT e.ename, m.ename, u.ename, q.ename
FROM emp e, emp m, emp u, emp q
WHERE e.mgr = m.empno AND m.mgr = u.empno AND u.mgr = q.empno;

--dept 4* 4* 4
SELECT *
FROM dept s, dept a, dept c;

--여러 테이블을 이용한 ANSI JOIN을 이용한 JOIN
SELECT e.ename, m.ename, t.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
           JOIN emp t ON (m.mgr = t. empno);

--직원의 이름과, 해당 직원의 관리자 이름을 조회한다.
--단 직원의 사번이 7369~7698인 직원을 대상으로 조회

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON e.mgr = m.empno
WHERE e.empno BETWEEN 7369 AND 7698;

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON e.mgr = m.empno
WHERE e.empno >= 7369 
AND e.empno <= 7698;


--NON -EQUI JOIN 조인조건이 =(equai)이 아닌 애들
--!=, BETWEEN AND



SELECT *
FROM salgrade;

SELECT empno, ename, sal ,salgrade.grade
FROM emp JOIN salgrade ON emp.sal BETWEEN salgrade.Losal AND salgrade.hisal;
          

SELECT empno, ename, sal ,salgrade.grade
FROM emp JOIN salgrade ON emp.sal >= salgrade.Losal 
                       AND emp.sal <= salgrade.hisal;
                       

--실습 join0

SELECT *
FROM emp;

SELECT empno, ename, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno;


SELECT empno, ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER by deptno;

--실습 join0_1

SELECT empno, ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND dept.deptno IN (10, 30)
ORDER by empno;

SELECT empno, ename, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND dept.deptno IN (10, 30)
ORDER by empno;

--실습 join0_2

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal > 2500
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 2500
ORDER by deptno;



--실습 join0_3


SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500
AND empno > 7600
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 2500 AND empno > 7600
ORDER by deptno;


-- 실습 join0_4

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500
AND empno > 7600
AND DNAME = 'RESEARCH'
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno 
                    AND emp.sal > 2500 
                    AND empno > 7600 
                    AND DNAME = 'RESEARCH'
ORDER by deptno;


--실습 join 1
SELECT *
FROM prod;
SELECT *
FROM LPROD;

SELECT LPROD_GU, LPROD_NM, PROD_ID, PROD_NAME
FROM prod, lprod
WHERE PROD_LGU = LPROD_GU
ORDER BY prod_id;