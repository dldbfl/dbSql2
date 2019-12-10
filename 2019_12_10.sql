--제약조건 활성화;/ 비활성화
--ALTER TABLE 테이블명 ENABLE OR DISABLE 제약조건명;

--USER_CONSTRAINTS view를 통해 dept_test 테이블에 설정된 제약조건 확인

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

ALTER TABLE dept_test DISABLE CONSTRAINT SYS_C007131;

SELECT * FROM dept_test;

--dept_test 테이블의 deptno 컬럼에 적용된 PRIMARY KEY 제약조건을 비활성화 하여 
--동일한 부서번호를 갖는 데이터를 입력할수 있다.
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO dept_test VALUES (99,'DDIT','대전');

--dept_test 테이블의 PRIMARY KEY 제약조건 활성화
--이미 위에서 실행한 두개의 INSERT 구문에 의해 같은 부서번호르 갖는 데이터가
--존재하기 때문에 PRIMARY KEY 제약조건을 활성화 할 수 없다.
--활성화 하려면 중복데이터를 삭제 해야한다.
ALTER TABLE dept_test ENABLE CONSTRAINT SYS_C007131;

--부서번호가 중복되는 데이터만 조회하여
--해당 데이터에 대해 수정 후 PRIMARY KEY 제약조건을 활성화 할 수 있다.
SELECT
    deptno, COUNT(*)
FROM dept_test
GROUP BY deptno
HAVING COUNT (*) >=2;

--talbe_name, constraints_name, column_name
--position 정렬(ASC)

SELECT*
FROM user_constraints
WHERE table_name = 'BUYER';

SELECT*
FROM user_cons_columns
WHERE table_name= 'BUYER';

--테이블에 대한 설명(주석) VIEW
SELECT *
FROM USER_TAB_COMMENTS;
SELECT *
FROM USER_COL_COMMENTS;

--테이블 주석
--COMMENT ON TABLE 테이블명 IS '주석';
COMMENT ON TABLE dept IS '부서';

--컬럼 주석
--COMMENT ON COLUMN 테이블.컬럼명 IS '주석';
COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서위치 지역';

--실습 comment1

--user_tab_comments, user_col_comments view를 이용하여 
--customer, product, cycle, daily 테이블과 컬럼의 주석정보를 조회하는 쿼리를 작성하리라
SELECT a.TABLE_NAME,TABLE_TYPE,a.comments tab_commets, b.COLUMN_NAME, b.COMMENTS col_commets
FROM USER_TAB_COMMENTS a, USER_COL_COMMENTS b
WHERE a. TABLE_NAME = b. table_name
AND a.table_name IN ('CUSTOMER', 'PRODUCT','CYCLE','DAILY');

SELECT
    *
FROM user_tab_comments;

--VIEW : QUERY는 쿼리이다.(O)
--테이블처럼 데이터가 물리적으로 존재하는 것이 아니외다.
--논리적 데이터 셋 = QUERY
--VIEW는 테이블이다(X)

--VIEW 생성
--CREATE OR REPLACE VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2...)] AS
--SUBQUERY

--emp테이블에서 sal, comm컬럼을 제외한 나머지 6개 컬럼만 조회가되는 view
--v_emp이름으로 생성

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;


--SYSTEM 계정에서 작업
--VIEW 생성 권한을 PC03에게 부여
GRANT CREATE VIEW TO PC03;

SELECT *
FROM v_emp;

--INLINE VIEW
SELECT
    *
FROM(SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp);

--emp 테이블을 수정하면 view에 영향이 갈까?
--KING의 부서번호가 현재 10번
--emp 테이블의 KING의 부서번호 데이터를 30번으로 수정(COMMIT)
--v_emp 테이블에서 KING의 부서번호를 관찰

UPDATE emp SET deptno = 30

SELECT *
FROM emp
WHERE ename = 'KING';

rollback;

--조인된 결과를 view로 생성
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno eno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM V_EMP_DEPT;

--emp ㅔㅌ이블에서 king 데이터 삭제(commit 하지말것)
DELETE emp
WHERE ename = 'KING';

rollback;
--emp 테이블의 empno컬럼을 eno로 컬럼이름 변경
ALTER TABLE emp RENAME COLUMN empno TO eno;
ALTER TABLE emp RENAME COLUMN eno TO empno;

SELECT * FROM V_EMP_DEPT;

drop view v_emp;



DELETE emp
WHERE ename= 'brown';

INSERT INTO EMP VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        TO_DATE('17-NOV-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'), 5000, NULL, 10);

commit;


-- 부서별 직원의 급여 합계
CREATE OR REPLACE VIEW v_emp_sal AS
SELECT deptno , sum(sal) sum_sal
FROM emp
GROUP BY deptno;

SELECT
    *
FROM(SELECT deptno , sum(sal) sum_sal
        FROM emp
        GROUP BY deptno)
WHERE deptno = 20;


--SEQUENCE
--ORACLE객체로 중복되지않는 정수값을 리턴해주는 객체
--cREATE SEQUENCE 시퀀스명
--[옵션...]

CREATE SEQUENCE seq_board;
DROP SEQUENCE seq_board;

--시퀀스 사용방법 : 시퀀스명.nextval
--연월일-순번
SELECT TO_CHAR(sysdate,'yyyymmdd')||'-'||seq_board.nextval
FROM dual;

SELECT seq_board.currval
FROM dual;                                      

CREATE SEQUENCE  "PC03"."SEQ_BORAD"
MINVALUE 1
MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 1 
CACHE 20 
NOORDER  
NOCYCLE ;


SELECT emp.*
FROM emp;

--emp 테이블 empno 컬럼으로 PRIMARY KEY 제약 생성: pk_emp
--dept 테이블 deptno 컬럼으로 PRIMARY KEY 제약 생성: pk_dept
--emp 테이블의 empno컬럼이 dept테이블의 deptno컬럼을 참조하도록
--FOREIGN KEYT 제약 추가 : fk_dept_deptno

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEy(empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEy(deptno);
ALTER TABLE emp ADD CONSTRAINT fk_dept_deptno FOREIGN KEY(deptno)
            REFERENCES dept (deptno);
            
--emp_test 테이블 삭제
DROP TABLE emp_test;

--emp 테이블을 이용하여 emp_test 테이블 생성
CREATE TABLE emp_test As 
SELECT *
FROM emp;