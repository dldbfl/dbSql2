(SELECT ENAME, SAL, deptno, rownum
 FROM(SELECT *
        FROM(SELECT ENAME, SAL, deptno
            FROM emp
            WHERE deptno = 10
            OrDer BY sal desc)))

UNION ALL

(SELECT ENAME, SAL, deptno, rownum
 FROM(SELECT *
        FROM(SELECT ENAME, SAL, deptno
            FROM emp
            WHERE deptno = 20
            OrDer BY sal desc)))

UNION ALL

(SELECT ENAME, SAL, deptno, rownum
 FROM(SELECT *
        FROM(SELECT ENAME, SAL, deptno
            FROM emp
            WHERE deptno = 30
            OrDer BY sal desc)));
 ----


SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
    WHERE b.cnt >= a.rn
    ORDER BY b.deptno, a.rn )) b
WHERE a.j_rn = b.j_rn;

--ana0-을 분석함수로
SELECT ename, sal, deptno,
       RANK() OVER (PARTITION BY deptno ORDER BY sal )rank,
       dense_RANK() OVER (PARTITION BY deptno ORDER BY sal ) dense_rank,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal )row_number
       
FROM emp;       

--실습 ana1

SELECT empno,ename, sal, deptno,
       RANK() OVER (ORDER BY sal desc,empno)rank,
       dense_RANK() OVER (ORDER BY sal desc,empno) dense_rank,
       ROW_NUMBER() OVER (ORDER BY sal desc,empno)row_number
       
FROM emp;       

--실습 no_ana2
SELECT b.empno, b.ename, a.*
FROM  (SELECT deptno, COUNT(deptno) cnt
      FROM emp
      GROUP BY deptno)a,
      emp b
WHERE a.deptno = b.deptno      
ORDER BY cnt;      

--사원번호, 사원이름, 부서번호, 부서의 직원수
SELECT empno, ename, deptno, COUNT(*)OVER (PARTITION BY deptno) cnt,  COUNT(empno)OVER (PARTITION BY empno) cnt
FROM emp;

--실습 ana2
--window 펑션을 잉ㅇ하여 모든 사원에 대해 사원번호 ,사원이름, ㅂㄴ인급여, 부서번호와 해당사웡ㄴ이 속한 부서의 급여 평균을
--조회하는 ㅈ쿼리를 작성, (소수점 2째자리까지)
SELECT empno, ename,sal, deptno, 
       ROUND(avg(sal) OVER (PARTITION BY deptno),2) cnt
FROM emp;

--실습 ana3
SELECT empno, ename,sal, deptno, 
       MAX(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;
--실습 ana4
SELECT empno, ename,sal, deptno, 
       MIN(sal) OVER (PARTITION BY deptno) MIN_sal
FROM emp;

SELECT empno, ename, hiredate, sal, 
       LEAD(sal) over(ORDER BY sal desc, hiredate) lead_sal
FROM emp;

--실습 ana5
SELECT empno, ename, hiredate, sal, 
       LAG(sal) over(ORDER BY sal desc, hiredate) lead_sal
FROM emp;
--실습 ana6
SELECT empno, ename, hiredate, job, sal,
       (LAG(sal) over(PARTITION  BY job ORDER BY sal desc, hiredate)) LAG_sal
FROM emp;

--실습 no_ana3
a.rn >= b.rn

SELECT a1.rownum
FROM  (SELECT a.* ,rownum
        FROM(   SELECT empno, ename, hiredate, sal
                FROM emp
                GrOUP BY empno, ename, hiredate, sal
                ORDER BY sal,HIREDATE)a)a1,
        (SELECT b.* ,rownum
         FROM(   SELECT empno, ename, hiredate, sal
                FROM emp
                GrOUP BY empno, ename, hiredate, sal
                ORDER BY sal,HIREDATE)b)a2
WHERE a1.rownum >= a2.rownum;                