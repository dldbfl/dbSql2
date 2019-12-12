--INDEX만 조회하여 사용자의 요구사항에 만족하는 데이터를 만들어
--낼 수 있는 경우

SELECT * 
FROM emp;

SELECT * 
FROM emp
ORDER BY empno;

--emp 테이블의 모든 컬럼을 조회
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

--emp 테이블의 empno 컬럼을 조회
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

--기존 인덱스 제거 
--pk_emp 제약조건 삭제 --> unique 제약 삭제 --> pk_emp 인덱스 삭제

--INDEX 종류( 컬럼 중복 여부)
--UNIQUE INDEX : 인덱스 컬럼의 값이 중복될 수 없는 인덱스
--               (emp.empno, dept.deptno)
--NON-UNIQUE INDEX(default) : 인덱스 컬럼의 값이 중복될 수 있는 인덱스 (emp.job)

ALTER TABLE emp DROP CONSTRAINT pk_emp;

--CREATE UNIQUE INDEX idx_n_emp_01 ON emp (empno);

--위쪽 상황이랑 달라진 것은 empno 컬럼으로 생성된 인덱스가
--UNIQUE -> NON -UNIQUE 인덱스로 변경됨
--이렇게 되면 중복되는 값이 또 있을 수 있으니 계산하다 멈추는게 아니라 밑으로 계속 계산하러간다.
--중복된거 있으면 값+1번더 검색해서 중복된게 없는걸 확인하고 연산을 멈춘다네 

CREATE INDEX idx_n_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE empno =7782;

SELECT *
FROM TABLE (dbms_xplan.display);

--7782
DELETE emp WHERE ename = 'brown';
INSERT INTO emp emp (empno, ename) VALUES (7782,'brown');
commit;

--emp 테이블에 job 컬럼으로 non-unique 인덱스 생성
--인덱스명 idx_n_emp_02

CREATE INDEX idx_n_emp_02 ON emp(job);

SELECT job, rowid
FROM emp
ORDER BY job;

--emp 테이블에는 인덱스 가 2개 존재
--1. empno
--2. job

SELECT *
FROM emp
WHERE empno = 7369;

--IDX_02 dlseprtm
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job= 'MANAGER'
AND ename LIKE 'c%';

SELECT *
FROM TABLE (dbms_xplan.display);

--idx_n_emp_03
--emp 테이블의 job , ename 컬럼으로 non-unique 인덱스 생성
CREATE INDEX idx_n_emp_03 ON emp (job, ename);


--idx_n_emp_04
--emp 테이블의 ename, job컬럼으로 non-unique인덱스 생성
CREATE  INDEX idx_n_emp_04 ON emp (ename, job);

SELECT ename , job, rowid
FrOM emp
ORDER BY ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE 'J%' ;


SELECT *
FROM TABLE (dbms_xplan.display);


--join 쿼리에서의 인덱스
--emp 테이블은 empno커럼으로 primary key 제약조건이 존재
--dept테이블은 deptno컬럼으로 primary key 제약조건이 존재
--emp 테이블은 primary key 제약을 삭제한 상태이므로 생성
DELETE emp
where ename = 'brown';
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

commit;


EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

sELECT *
FROM TABLE (dbms_xplan.display);


DROP TABLE dept_test;

CREATE TABLE dept_test AS 
    SELECT *
    FROM dept
    WHERE 1 = 1;
    
CREATE UNIQUE INDEX idx_n_dept_01 ON dept_test (deptno);
CREATE INDEX idx_n_dept_02 ON dept_test (dname);
CREATE INDEX idx_n_dept_03 ON dept_test (deptno,dname);


--idx2

DROP INDEX idx_n_dept_03;

