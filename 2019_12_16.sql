--GROUPING SETS(col1, col2)
--다음과 결과가 동일
--개발자가 GROUP BY 의 기준을 직접 명시한다
--ROLLUP과는 달리 방향성을 갖지 않는다
--GROUPING SET(col1. col2) = GROUPING SETS(col2.col1)

--GROUP BY col1
--UNION ALL
--GROUP BY col2

--GROUP BY col2
--UNION ALL
--GROUP BY col1

--emp 테이블에서 직원의 job(업무)별 급여 (sal)+상여(comm)합,
--                    deptno(부서, 급여(sal), + 상여(comm) 합
--기존방식 (GROUP FUNCTION) : 2번의 sql 작성 필요(UNION/ UNION ALL)

SELECT job ,null deptno, sum (sal+NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY job
UNION ALL
SELECT '', deptno, sum(sal+NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY deptno;

--GROUPING SETS 구문을 이용하여 위의 SQL을 집합연산을 사용하지 않고
--테이블을 한번 읽어서 처리
SELECT job, deptno, SUM(sal+NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);


--job, deptno를 그룹으로 한 sal_comm 합
--mgr을 그룹으로 한 sal+comm합
--gROUP BY job, deptno 
--UNION ALL
--GROUP BY mgr
-- --> GROUPING SETS ((job, deptno), mgr)
--null가지고 체크하면 계산널값이 아닐수도있다. 그러니 grouping도 응용
SELECT job ,deptno ,mgr,  sum(sal+NVL(comm,0)) sal_comm_sum,
        GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETs ((job,deptno),mgr);


--CUBE( col1, col2, ...)
-- 나열된 컬럼의 모든 가능한 조합으로 GROUP BY subset을 만든다
-- CUBE에 나열된 컬럼이 2개인 경우 : 가능한 조합 4개
-- CUBE에 나열된 컬럼이 3개인 경우 : 가능한 조합 8개
-- CUBE에 나열된 컬럼수를 2의 제곱한 결과가 가능한 조합 개수가 된다 (2^n)
--컬럼이 조금만 많아져도 가능한 조합이 기하급수적으로 늘어나기 때문에
--많이 사용하지는 않는다.

-- job, deptno를 이용하여 CUBE 적용
SELECT job, deptno, SUM (sal+NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
--job, deptno
--1,    1   --> GROUP BY job, depntno
--1,    0   --> GROUP BY job
--0,    1   --> GROUP BY depntno
--0,    0   --> GROUP BY --emp테이블의 모든행에 대해 group by

--GROUP BY 응용
--GROUP BY , ROLLUP,CUBE를 섞어 사용하기
--가능한 조합을 생각해보면 쉽게 결과를 예측할 수 있다.
--GROUP BY JOB, rollup( deptno), cube(mgr)

SELECT job, deptno,mgr,SUM (sal+NVL(comm,0)) sal_comm_sum,
            Grouping(job),Grouping(deptno),Grouping(mgr)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

--

SELECT job, job, sum(sal)
FROM emp
GROUP BY job,job;

select *
from dept_test;

--subqurey_ sub_a1

DROP TABLE dept_test;

CREATE TABLE dept_test AS SELECT* 
                          FROM dept;
                          
SELECT * fROM dept_test;

ALTER TABLE dept_test ADD(empcnt number);

-- 첫번쨰껀 안됨
UPDATE dept_test
SET empcnt = (SELECT count(dept.deptno)
              FROM emp,dept
              WHERE emp.deptno = dept.deptno
              group by emp.deptno)
              ;
              
UPDATE dept_test
SET empcnt = (SELECT count(deptno)
              FROM emp
              WHERE emp.deptno = dept_test.deptno);
   

SELECT * fROM dept_test;


--sub_a2
DROP TABLE dept_test;

CREATE TABLE dept_test AS SELECT* 
                          FROM dept;
                          
insert into dept_test values(99, 'it1', 'daejeon');
insert into dept_test values(98, 'it2', 'daejeon');

select *
FROM dept_test;

DELETE FROM dept_test
WHERE deptno NOT IN (SELECT dept_test.deptno
                     FROM emp
                     WHERE dept_test.deptno = emp.deptno);
                     
DELETE FROM dept_test
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                    );                                

--서브쿼리 ADVANCED (correlated subquery delete - 실습 sub_a3)

DROP TABLE emp_test;

CREATE TABLE emp_test AS SELECT* 
                          FROM emp;
                          
UPDATE emp_test SET sal = sal+200 
WHERE ename IN ( SELECT ename
                 FROM emp a, (SELECT deptno, avg(sal) avg_sal
                              FROM emp
                              GROUP BY deptno)b
                 WHERE  a.deptno = b.deptno 
                 AND    a.sal < b.avg_sal
                );
---------------
UPDATE emp_test SET sal = sal+200 
WHERE sal < (SELECT ROUND(AVG(sal),2)
             FROM emp_test
             WHERE deptno = emp_test.deptno
             );
             
SELECT ename, a.deptno, a.sal, b.avg_sal
FROM emp_test a , (SELECT ROUND(AVG(sal),2) avg_sal
                    FROM emp_test
                    WHERE deptno = emp_test.deptno
                   )b;
SELECT *
FROM emp_test
WHERE sal < (SELECT ROUND(AVG(sal),2)b
             FROM emp_test
             WHERE deptno = emp_test.deptno
             ) ;


             
SELECT ROUND(AVG(sal),2)
        FROM emp_test
        WHERE deptno = emp_test.deptno
             group by deptno;             
             
             
             
             
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno ) b
ON (a.deptno = b.deptno) 
WHEN MATCHED THEN
    UPDATE SET sal = sal+200
    WHERE a.sal < avg_sal;


MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno) b
ON (a.deptno = b.deptno) 
WHEN MATCHED THEN
    UPDATE SET sal = CASE
                        WHEN a.sal< b.avg_sal THEN sal+200
                        ELSE sal
                     END;