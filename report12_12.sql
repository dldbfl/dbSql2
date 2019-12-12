EXPLAIN PLAN for
-- 사번 찾기;
SELECT *
FROM emp
WHERE empno = :empno;

-- 이름 찾기
EXPLAIN PLAN for
SELECT *
FROM emp
WHERE ename = :ename;

-- 
EXPLAIN PLAN for

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = :deptno;
AND emp.empno LIKE :empno || '%';
(deptno,empno);
--

EXPLAIN PLAN for
SELECT *
FROM emp
WHERE sal BETWEEN :st_sal AND :ed_sal
AND deptno = :deptno;
(deptno,sal)
--

EXPLAIN PLAN for
SELECT b.*
FROM emp A, emp B
WHERE A.mgr = B.empno
AND A.deptno = :deptno;
    
    empno
    ename
    deptno,sal
    deptno,empno
    empno,deptno;
DROP INDEX idx_n_emp_05;
DROP INDEX idx_n_emp_06;
DROP INDEX idx_n_emp_07;
DROP INDEX idx_n_emp_08;
DROP INDEX idx_n_emp_09;
DROP INDEX idx_n_emp_10;
DROP INDEX idx_n_emp_11;
);


--
EXPLAIN PLAN for
SELECT deptno, TO_CHAR(hiredate, 'yyymm'),
      COUNT(*) cnt
      FROM EMP
      GROUP BY deptno, TO_CHAR(hiredate, 'yyymm');

SELECT*
FROM TABLE (dbms_xplan.display);
