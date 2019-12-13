SELECT * FROM emp_test
ORDER BY EMPNO;

--emp 테이블에 존재하는 데이터를 emp_test 테이블로 머지
--만약 empno 가 동일한 데이터가 존재하면
--ename update : ename || '_merge'
--만약 empno가 동일한 데이터가 존재하지 않을 경우
--emp테이블의 empno, ename emp_test 데이터로 insert

--emp_test 데이터에서 절반의 데이터를 삭제
DELETE EMP_TEST
WHERE EMPNO>=7788;
commit;

--emp 테이블에는 14건의 데이터가 존재
--emp_test 테이블에는 사번이 7788보다 작은 7명의 데이터가 존재
--emp 테이블을 이용하여 emp_test 테이블을 머지하게 되면
--emp 테이블에만 존재하는 직원 (사번이 7788보다 크거나 같은 직원) 7명
--emp_test로 새롭게 insert가 될 것이고
--emp, emp_test 사원번호가 동일하게 존재하는 7명의 데이터는 
--(사번이 7788보다 작은 직원) ename 컬럼의 enmae || '_modify'로
--업데이트를 한다.

/*
MERGE INTO 테이블명
USING 머지대상 테이블|VIEW|SUBQUERY
ON (테이블명과 머지대상의 연결관계)
WHEN MATCHED THEN
    UPDATE .....
WHEN NOT MATCHED THEN 
    INSERT....
*/

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES(emp.empno, emp.ename);



-- emp_test 테이블에 사번이 9999인 데이터가 존재하면
--ename을 'brown'으로 update
--존재하지않을 경우 empno, ename VALUES (9999,'brown') 으로 insert
--위의 시나리오를 MERGE 구문을 활용하여 한번의 sql로 구분
MERGE INTO emp_test
USING dual
ON (emp_test.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = : ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (: empno, : ename);
    
--만약 merge 구문이 없다면
--1. empno = 9999인 데이터가 존재하는지 확인
--2-1. 1번사항에서 데이터가 존재하면 UPDATE
--2-2. 1번사항에서 데이터가 존재하지않으며 INSERT

SELECT deptno, sum(sal)
FROM emp
GROUP BY deptno
union 
SELECT null ,sum(sal)
FROM emp;

--join 방식으로 풀이
--emp 테이블의 14건에 데이터를 28건으로 생성
--구분자 (1-14, 2-14)를 기준으로 group by
--구분자 1 : 부서번호 기준으로 14row
--구분자 2 : 전체 14 row

SELECT DECODE(b.rn, 1, emp.deptno , 2,null) deptno, 
        sum(emp.sal) sal
        
FROM emp,(SELECT ROWNUM rn
          FROM dept
          WHERE ROWNUM <=2) b
          
GROUP BY DECODE(b.rn, 1, emp.deptno , 2,null)
ORDER BY DECODE(b.rn, 1, emp.deptno , 2,null);

--

SELECT DECODE(b.rn, 1, emp.deptno , 2,null) deptno, 
        sum(emp.sal) sal

FROM emp,(SELECT LEVEL rn
          FROM dual
          CONNECT BY LEVEL <=2) b
          
GROUP BY DECODE(b.rn, 1, emp.deptno , 2,null)
ORDER BY DECODE(b.rn, 1, emp.deptno , 2,null);

--REPORT GROUP BY 
--ROLLUP
--GROUP BY ROLLUP(col1....)
--ROLLUP 절에 기술된 컬럼을 오른쪽에서부터 지원 결과로
--SUB GROUP을 생성하여 여러개의 GROUP BY 절을 하나의 SQL에서 실행되도록 한다.

--ROLLUP은 컬럼 순서가 조회 결과에 영향을 미친다.
GROUP BY ROLLUP (job, deptno)
--group by job, deptno
--group by job
--group by --> 전체행 대상으로 group by 

--emp 테이블을 이용하여 부서번호별 , 전체ㅐ직원별 급여합을 구하는 쿼리를 
--rollup 기능일 이용하여 작성하라

SELECT deptno, sum(sal) sal
from emp
GROUP BY ROLLUP (deptno);

--emp 테이블을 이용해서 job, deptno 별 sal+ comm합계
--                    job 별 sal_comm 합계
--                    전체직원의 sal_comm 합계
--rollup을 사용하여 작성

SELECT job, deptno, sum(sal+NVL(comm,0))
FROm emp
GROUP BY ROLLUP (job, deptno);
--group by job, deptno
--group by job
--group by --> 전체행 대상으로 group by 


SELECT job, deptno, sum(sal+NVL(comm,0))sal
FROm emp
GROUP BY job, deptno UNION ALL

SELECT job, null,
         sum(sal+NVL(comm,0))sal
FROm emp
GROUP BY job UNION ALL 

SELECT null, null, 
        sum(sal+NVL(comm,0))sal
FROm emp;


--group by rollup function---

SELECT NVL(job, '총계'), deptno, sum(sal+NVL(comm,0)) sal
FROm emp
GROUP BY ROLLUP (job, deptno);

---

SELECT DECODE(GROUPING(job),1, '총계',job) job, deptno, sum(sal+NVL(comm,0)) sal
FROm emp
GROUP BY ROLLUP (job, deptno);

--ad2_2
--수정요망--불가능할거같다.
SELECT DECODE(GROUPING(job),1, '총',job) job, 
       DECODE(GROUPING(job),0, DECOD0E(b.gpb,1,'소계',deptno),1,
                               DECODE(b.gpb,1,'계',deptno)), sal
FROM emp ,(SELECT DECODE(GROUPING(job),1, '총',job) job, deptno,GROUPING(deptno)gpb, sum(sal+NVL(comm,0)) sal
           FROm emp
           GROUP BY ROLLUP (deptno,job))b

GROUP BY ROLLUP (job,deptno);

SELECT DECODE(GROUPING(job),1, '총',job) job, 
       DECODE(GROUPING(job),0, DECODE(GROUPING(deptno),1, '소계',deptno),
                            1, DECODE(GROUPING(deptno),1, '계',deptno)) deptno , sum(sal+NVL(comm,0)) sal 
 
FROM emp 
GROUP BY ROLLUP (job,deptno);
--선생님꺼
SELECT job, deptno, DECODE(GROUPIng(job),1,'총',job) job,
       CASE
           WHEN deptno IS NULL AND job IS NULL THEN '계'
           WHEN deptno IS NULL AND job IS NOT NULL THEN '소게'
           ELSE '' || deptno
       END,
       sum(sal+NVL(comm,0)) sal 
 
FROM emp 
GROUP BY ROLLUP (job,deptno);
      
SELECT DECODE(GROUPING(job),1, '총',job) job, deptno,GROUPING(deptno), sum(sal+NVL(comm,0)) sal
FROm emp
GROUP BY ROLLUP (deptno,job);

--group ad3--
SELECT deptno, job, sum(sal+NVL(comm,0)) sal
FROm emp
GROUP BY ROLLUP (deptno,job)
ORDER BY deptno;

--UNION ALL 로 치환
SELECT deptno, job, SUM (sal+NVL(comm,0)) sal_sum
FROM emp
GROUP BY deptno, job

UNION ALL

SELECT deptno, null,SUM (sal+NVL(comm,0)) sal_sum
From EMP
GROUP by deptno;





--group ad4--

SELECT dname, job, sum(sal+NVL(comm,0)) sal
FROm emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname,job)
ORDER BY dname, job DESC;

select * from DEPT;
SELECT * FROM emp;
 ----------------------
SELECT dept.dname, a.job, a.sal
FROM
    (SELECT deptno, job, sum(sal+NVL(comm,0)) sal
     FROm emp
     GROUP BY ROLLUP (deptno,job))a, dept
WHERE a.deptno = dept.deptno(+);

ORDER BY dname, job DESC;

select * from DEPT;
SELECT * FROM emp;





--group ad 5-- 

SELECT DECODE(GROUPING(dname),1,'총계',dname) dname ,job, sum(sal+NVL(comm,0)) sal
FROm emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname,job)
ORDER BY dname, job DESC;

