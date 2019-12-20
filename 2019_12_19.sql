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

select a.empno, a.ename, a.sal1,sum(sal2) as c_sum
from
    (select empno,ename,rownum as rn1, sal1
     from (select empno, ename,sal as sal1
           from emp
           order by sal)) a,
    (select rownum as rn2, sal as sal2
     from (select sal
           from emp
           order by sal)) b
where a.rn1 >= b.rn2
group by a.empno, a.ename, a.sal1
rder by c_sum;


-- 사원번호, 사원이름, 부서번호, 급여, 부서원의 전체 급여합
select empno, ename, deptno, sal,
        Sum(sal) over(ORDER BY sal
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum1, -- 가장 첫 행부터 현재행까지
        Sum(sal) over(ORDER BY sal
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum2,  --바로 이전행부터 현재행까지 
        Sum(sal) over(ORDER BY sal
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum3,  --바로 이전행부터 현재행까지
        Sum(sal) over(ORDER BY sal
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) c_sum4 -- 현재행부터 마지막행까지
FROM emp
;               

--ana7 unbounded
SELECT empno, ename, deptno, sal,
       SUM(sal) over (PARTITION BY deptno ORDER BY sal, empno)c_sum
FROM emp;       


--ROWS vs RANGE 차이 확인하기
SELECT empno, ename, deptno, sal,
       sum(sal) OVER (ORDER BY sal ROWs UNBOUNDED PRECEDING) row_sum,
       sum(sal) OVER (ORDER BY sal Range UNBOUNDED PRECEDING) range_sum,
       sum(sal) OVER (ORDER BY sal ROWs UNBOUNDED FOLLOWING) rowfollow_sum,
       sum(sal) OVER (ORDER BY sal) c_sum  --안썻으면 Range UNBOUNDED PRECEDING 디폴트다.ㄱ
FROM emp;       