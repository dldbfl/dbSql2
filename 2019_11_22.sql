--where8 (emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.(IN, NOT IN)

SELECT
    *
FROM emp 
WHERE DEPTNO NOT LIKE '10' AND HIREDATE > TO_DATE('19810601','yyyymmdd');

SELECT
    *
FROM emp
WHERE DEPTNO != 10 --<>, !=
AND HIREDATE > to_date('19810601','yyyymmdd'); --sql에서는 깔끔하게 한다. 위에꺼로 하면 아래껄로 만든다. (!!LIKE 다음에는 패턴이 나와야 알맞다!!)

--WHERE9 emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요. (NOT IN 사용)

SELECT
    *
FROM emp
WHERE DEPTNO NOT IN '10'
AND HIREDATE > to_date('19810601','yyyymmdd');

--WHERE 10 emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요.
--(부서는 10, 20 ,30만 있다고 가정하고 IN 연산자를 사용

SELECT
    *
FROM emp
WHERE DEPTNO IN (20,30)
AND HIREDATE > TO_DATE('19810601','yyyymmdd');

--WHERE 11 emp 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음곽 같이 조회하세요.

SELECT
    *
FROM emp
WHERE JOB LIKE 'S%' 
OR HIREDATE > TO_DATE('19810601','yyyymmdd');

--WHERE 12 emp 테이블에서 JOb이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조호히하세오
SELECT
    *
FROM emp
WHERE JOB = 'SALESMAN'
OR EMPNO LIKE '78%';

--WHERE 13 emp 테이블에서 job가 salesman 이거나 사원번호가 78로 시작하는 직원의 정보를 다음과같이 조회하시오(LIKE 사용 ㄴ)
DESC emp; -- 유형 number(a) = a갯수의 숫자가 들어갈수있다.
SELECT
    *
FROM emp
WHERE JOB = 'SALESMAN'
OR empno BETWEEN 7800 AND 7899;

SELECT
    *
FROM emp
WHERE JOB = 'SALESMAN'
OR empno >7800 
AND empno < 7899;


--연산자 우선순위 (AND > OR)
--직우너 이름이 smith 이거나, 직원이름이 allen이면서 역할이 salesman인 직원

SELECT
    *
FROM emp
WHERE ename = 'SMITH'
OR ename = 'ALLEN'
AND job = 'SALESMAN';

SELECT
    *
FROM emp
WHERE ename = 'SMITH'
OR (ename = 'ALLEN' AND job = 'SALESMAN');


--직원이름이 smith 이거나 aleen이면서 역할이 salesman인사람
SELECT
    *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

--where 14 emp 테이블에서 job이 salesman이거나 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 직원의 정보를 조회하세오
SELECT
    *
FROM emp
WHERE job = 'SALESMAN' OR empno like '78%' AND HIREDATE > to_date('19810601','yyyymmdd');

--데이터정렬
--오름차순 : ASC (표기생략가능) 기본값
--내림차순 : DESC (생략불가

/*
    SELECT coll, col2, ....
    FROM 테이블명
    WHERE col1 = '값'
    ORDER BY 정렬기준컬럼1 [ASC /DESC] , 정렬기준컬럼2....[ASC /DESC]
    */
    
--사원 (emp) 테이블에서 직원의 정보를 직원 이름으로 오름차순

SELECT
    *
FROM emp
ORDER BY ENAME ASC; -- 생략해도 동일하다.
    
    
--사원 (emp) 테이블에서 직원의 정보를 직원 이름으로 오름차순

SELECT
    *
FROM emp
ORDER BY ENAME DESC; -- 생략하면 오름차순되버린다.

--사원 (emp) 테이블에서 직원의 정보를 부서번호로 오름차순 정렬하고 부서번호가 같을때는 sal 내림차순으로 정렬
--급여(sal)가 같을때ㅡ는 이름으로 오름차순 정렬한다.
SELECT
    *
FROM emp
ORDER BY DEPTNO, SAL DESc, ename;


--정렬 컬럼을 ALIAS로 표현
SELECT
    deptno, sal, ename nm
FROM emp
ORDER BY nm;

--조회하는 컬럼의 위치 인덱스로 표현 가능

SELECT
    deptno, sal, ename nm
FROM emp
ORDER BY 3; --추천하지는 않는바이다. 컬럼이 추가될경우 값이 변경될수도있기때문이오!

--oder by 실습 1 
SELECT
    *
FROM dept
ORDER BY dname;

SELECT
    *
FROM dept
ORDER BY loc desc;

--order by 2
--emp테이블에서 상여comm정보가있는사람들만 조회하고 상여를 많이 받는사람이 먼저조회도록학하고 사여ㅓ
--상여같으면 오름차순
SELECT
    *
FROM emp
WHERE COMM IS NOT NULL
AND COMM !=0
ORDER BY COMM DESC, EMPNO ASC;

--order by3
--emp 테이블에서 관리자가 있는 사람들만 조회하고 직군 순으로 오름차순 정렬하고 직업이 같을 경우 사번이 큰 사원 이 먼저 조회도록 쿼리를 작성하세요.

SELECT
    *
FROM emp
WHERE MGR IS NOT NULL
ORDER BY JOB , EMPNO DESC;

--oderby4

SELECT
    *
FROM emp 
WHERE DEPTNO in ('10','30') AND SAL > 1500
ORDER BY ENAME DESC;

--ROWNUM 
SELECT ROWNUM, empno, ename
FROM emp;


SELECT
    *
FROM emp 
WHERE DEPTNO in ('10','30') AND SAL > 1500
ORDER BY ENAME DESC;


SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 2;       --ROUNUM = equal 비교는 1만 가능



SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM <= 2;       --<= (<) ROWNUM을 1부터 순차적으로 조회하는 경우는 가능

SELECT
    *
FROM emp 
WHERE DEPTNO in ('10','30') AND SAL > 1500
ORDER BY ENAME DESC;
       --1부터 시작하는 경우 가능


--SELECT 절과 ORDER BY 구문의 실행순서
--SELECT ->ROWNUM->ORDER BY


SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

--INLINE VIEW를 통해 정렬 먼저 실행하고, 해당결과에 ROWBNUM을 적용
--ㄴSELECT 절에 * 사용하고, 다른 칼럼|표현식을 썻을 경우
--*앞에 테이블 명이나 테이블 별칭을 적용 

SELECT empno, ename
      FROM emp
      ORDER BY ename;

SELECT ROWNUM, a.*
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename) a;
      
      
 --ROWNUM 실습1
--emp 테이블에서 ROWNUM 값이 1~10인 값만 조회하는 쿼리를 작성해보세요
SELECT ROWNUM rn, empno , ename
FROM emp
where ROWNUM <= 10;
      
   --ROWNUM 실습 2
   --ROWNUM 값이 11~20 (11~14)인 값만 조회하는 쿼리를 작서앻보세요.

SELECT ROWNUM rn, empno, ename
      FROM emp
      WHERE ROWNUM BETWEEN 11 AND 14; -- 요로케 비트윈하면 망해요  

SELECT ROWNUM RN, empno, ename
      FROM emp;   
   
   
SELECT a.*
FROM (SELECT ROWNUM RN, empno, ename
      FROM emp)a
WHERE RN >= 11 AND RN <= 20;

SELECT a.*
FROM (SELECT ROWNUM rn , empno, ename
      FROM emp) a
WHERE rn BETWEEN 11 AND 20;

--row_3
--emp ㅌ네이블에서 ename으로 정렬한 결과에 11번째 행과 14번째 행만 조회하는 쿼리를 작성해보세요

SELECT empno, ename
                FROM emp
                ORDER BY ename;

SELECT b.*
FROM(SELECT ROWNUM rn, a.*
        FROM (SELECT empno, ename
                FROM emp
                ORDER BY ename)a )b
WHERE rn IN (11,14);      


SEL LOWER('MR. SCOTT MCMILLAN') "Lowercase"
  FROM DUAL