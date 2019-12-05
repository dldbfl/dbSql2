INSERT INTO dept VALUES (99,'ddit','daejeon');

rollback;


SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

-- dept <> 40;  dept 가 40이 아닌것                    
                    
                    
SELECT *
FROM cycle;


SELECT pid, pnm
FROM product;


SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);

--sub6
--cid=2인 고객이 애음하는 제품중 cid = 1인 고객이 애음하는 제품의 애음정보를 조회

SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);
            
--sub7

SELECT * FROM cycle;
SELECT * FROM customer;
SELECT * FROM product;

SELECT cycle.cid, cnm, cycle.pid,pnm, day, cnt
FROM cycle,product,customer
WHERE cycle.cid = 1
AND product.pid = cycle.pid
AND cycle.cid = customer.cid
AND cycle.pid IN (SELECT cycle.pid
                 FROM cycle
                 WHERE cid = 2);
                 
                 
--매니저가 존재하는 직원 정보 조회                 
SELECT *
FROM emp a 
WHERE EXISTS(SELECT 1
            FROM emp b
            WHERE b.empno = a.mgr);
 
--SUB 8 EXISTS 연산자 실습

SELECT a.*
FROM emp a, emp b
WHERE b.empno = a.mgr;

SELECT *
FROM emp
WHERE mgr IS NOT NULL;


--sub 9 고객번호 exists

SELECT product.pid, pnm
FROM product
WHERE NOT EXISTS (SELECT 1
                  FROM cycle
                  WHERE cid=1
                  AND cycle.pid = product.pid);


--sub 10 고객번호 exists

SELECT product.pid, pnm
FROM product
WHERE  EXISTS (SELECT 1
               FROM cycle
               WHERE cid=1
               AND cycle.pid = product.pid);
               

-- 집합연산
--UNION : 합집합, 두 집합의 중복건은 제거한다.
--담당업무가 SALESMAN인 직원의 직원번호, 직원 이름 조회
--우 아래 결과셋이 동일하기 때문에 합집합 연산을 하게 될경우
--중복되는 데이터는 한번만 표현한다.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--서로 다른 집합의 합집합
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'CLERK';

--UNION ALL
--합집합 연산시 중복 제거를 하지 않는다.
--위아래 결과 셋을 붙여 주기만 한다.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--집합연산시 집합셋의 컬럼이 동일 해야한다.
--컬럼의 개수가 다를경우 임의의 값을 넣는 방식으로 개수를 맞춰준다.
SELECT empno, ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN';

-- INTERSECT : 교집합
--두 집합간 공통적인 데이터만 조회
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--MINUS
--차집합 : 위, 아래 집합의 교집합을 위 집합에서 제거한 집합을 조회
--차집합의 경우 합집합, 교집합과 다르게 집합의 선언 순서가 결과 집합에 영향을 준다.
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--ORDER BY 설정

SELECT empno, ename
FROM

(SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')
ORDER BY job)

UNION ALL

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN')
ORDER BY ename;

-- DML
-- INSERT : 테이블에 새로운 데이터를 입력
select * from dept;

--INSERT 시 컬럼을 나열한 경우
--나열한 컬럼에 맞춰 입력할 값을 동일한 순서로 기술한다.
--INSERT INTO 테이블명 (컬럼1, 컬럼2....)
--              VALUES (값1, 값2....)
--dept 테이블에 99번 부서번호, ddit 조직명, daejoen 이라는 지역명을 갖는 데이터를 입력해보자.
select * from dept;
INSERT INTO dept (deptno, dname, loc)
            VALUES (99, 'ddit', 'daejeon');

--컬럼을 기술할 경우 테이블의 컬럼 정의 순서와 다르게 나열해도 상관이 없다.
--dept 테이블의 컬럼 순서 : deptno, dname, location
INSERT INTO dept (loc, deptno, dname)
            VALUES ('daejeon', '99', 'ddit');
            
--컬럼을 기술하지 않는경우 : 테이블의 컬럼 정의 순서에 맞춰 값을 기술한다.
desc dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
            
--날짜 값 입력하기
--1. SYSDATE
--2. 사용자로 부터 받은 문자열을 DATE 타입으로 변경하여 입력
SELECT * FROM emp;
desc emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);
select * from emp WHERE empno = 9998;

--2019년 12월 2일 입사
INSERT INTO emp VALUES (9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'yyyymmdd'), 500, NULL, NULL);
select * from emp WHERE empno = 9997;

--여러건의 데이터를 한번에 입력
--SELECT 결과를 테이블에 입력 할 수 있다.
-- 유니온활용하여 INSERT 할수도 있음.
INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500,NULL, NULL 
FROM dual
UNION ALL
SELECT 9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'yyyymmdd'), 500, NULL, NULL
FROM dual;

select * from emp where empno in(9998, 9997);

rollback
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            