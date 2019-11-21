--where7
SELECT
    *
FROM emp
WHERE job IN 'SALESMAN' AND HIREDATE > to_date('19810601','yyyymmdd');     

--where8
SELECT
    *
FROM emp
WHERE ename NOT LIKE '10' AND HIREDATE > to_date('19810601','yyyymmdd');



--where9
SELECT
    *
FROM emp
WHERE ename NOT IN '10' AND HIREDATE > to_date('19810601','yyyymmdd');

--where10
SELECT
    *
FROM emp
WHERE deptno IN ('20','30') AND HIREDATE > to_date('19810601','yyyymmdd');

--where11
SELECT
    *
FROM emp
WHERE job IN 'SALESMAN' OR HIREDATE > to_date('19810601','yyyymmdd');

--where12
SELECT
    *
FROM emp
WHERE job IN 'SALESMAN' OR empno LIKE '78%';

--where13
SELECT
    *
FROM emp
WHERE job IN 'SALESMAN' OR empno IN '78';


--like는 %와 _를 사용가능 , IN은 두개이상일때 쓰면됨
SELECT
    *
FROM emp
WHERE deptNo = 10;

SELECT
    *
FROM emp
WHERE deptNo in (10, 20);

SELECT
    *
FROM emp
WHERE deptNo like '10%';