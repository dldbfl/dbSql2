--별칭: 테이블, 컬럼을 다른 이름으로 지칭
-- [AS] 별칭명
-- select empno [as] eno
-- from emp e

--SYNONYM (동의어)
--오라클 객체를 다른 이름으로 부를 수 있도록 하는 것
--만약에 emp 테이블을 e 라고 하는 동의어(synonym)로 생성을 하면
-- 다음과 같이 SQL을 작성할 수 있다.
-- SELECT *
-- FROM e;

--pc03계정에 synonym 생성 권한을 부여
GRANT CREATE synonym TO PC03;

--emp 테이블을 사용하여 synonym e를 생성
--create synonym 시노님 이름 for 오라클 객체;
CREATE SYNONYM e FOR emp;

--emp 라는 테이블 명 대신에 e 라고하는 시노님을 사용하여 쿼리를 작성
--할 수 있다.
SELECT *
FROM e;

--pc03계정의 fastfood 테이블을 hr 계정에서도 볼 수 있도록
--테이블 조회 권한을 부여
GRANT SELECT ON fastfood TO hr;


SELECT*
FROM dictionary;

SELECT *
FROM USER_SYNONYMS;

SELECT *
FROM USER_ind_columns;

--동일한 SQL의 개념에 따르면 아래 SQL들은 다르다.
SELECT /* 201911_205 */ * FROM emp;
SELECT /* 201911_205 */ * FROM EMP;
select /* 201911_205 */ * from emp;

SELECT * FROM V$SQL
WHERE SQL_TEXT LIKE '%201911_205%';

--multiple insert 
DROP TABLE emp_test;

--emp 테이블의 empno, ename 컬럼으로 emp_test, emp_test2 테이블을
--생성(CTAS, 데이터도 같이 복사)
CREATE TABLE emp_test AS 
    SELECT empno, ename
    FROM emp;

CREATE TABLE emp_test_2 AS 
    SELECT empno, ename
    FROM emp;    

--uncoditional insert
--여러 테이블에 데이터를 동시 입력
--brown,cony 데이터를 emp_test, emp_test2 테이블에 동시 입력
INSERT ALL
    INTO emp_test
    INTO emp_test_2
SELECT 9999,'brown' FROM DUAL UNION ALL
SELECT 9998,'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000;


rollback;
--테이블 별 입력되는 데이터의 컬럼을 제어가능.

INSERT ALL
    INTO emp_test (empno, ename) VALUES(eno, enm)
    INTO emp_test_2 (empno) VALUES(eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL
SELECT 9998,'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno>9000

UNION ALL

SELECT *
FROM emp_test_2
WHERE empno>9000;

rollback;

--conditional insert
--조건에 따라 테이블에 데이터를 입력

/*
    CASE
        WHEN 조건 THEN ----   //IF
        WHEN 조건 THEN ----   //ELSE IF
        ELSE ----            //ELSE
*/
ROLLBACK;
INSERT ALL
    WHEN eno>9000 THEN
        INTO emp_test(empno, ename) VALUES(eno, enm)
    WHEN eno>9500 THEN
        INTO emp_test(empno, ename) VALUES(eno, enm)
    ELSE 
        INTO emp_test_2(empno) VALUES (eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL
SELECT 8998,'cony' FROM DUAL;

SELECT * 
fROM emp_test
WHERE empno>9000 
UNION ALL
SELECT *
FROM emp_test_2
WHERE empno>8000;


ROLLBACK;
INSERT FIRST
    WHEN eno>9000 THEN
        INTO emp_test(empno, ename) VALUES(eno, enm)
    WHEN eno>9500 THEN
        INTO emp_test(empno, ename) VALUES(eno, enm)
    ELSE 
        INTO emp_test_2(empno) VALUES (eno)
SELECT 9999 eno,'brown' enm FROM DUAL UNION ALL
SELECT 8998,'cony' FROM DUAL;
