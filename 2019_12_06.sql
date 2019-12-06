select * from dept;

--dept 테이블에 부서번호 99 부서명 ddit 위치 daejeon

INSERT into dept
values(99, 'ddit', 'daejeon') ;

rollback;

commit;

--UPDATE : 테이블에 저장된 컬럼의 값을 변경
--UBDATE 테이블명 SET  컬럼명1= 적용하려고하는 값1, 컬럼명=적용하려고하는값2....)
--[WHERE row 조회 조건] -- 조회조건에 해당하는 데이터만 업데이트된다.

--부서번호가 99번인 부서의 부서명을 대덕IT로 , 지역을 영민빌딩으로 변경

UPDATE dept SET DNAME = '대덕IT', LOC = '영민빌딩'
WHERE deptno = 99;

SELECT *
FROM dept;
--업데이트 전에 업데이트 하려고 하는 테이블을 WHERE절에 기술한 조건으로 SELECT 하여 
--업데이트 대상 ROW 를 확인해보자

SELECT *
FROM dept
WHERE deptno= 99;

UPDATE dept SET DNAME = '대덕IT', LOC = '영민빌딩';
--다음 QUERY를 실행하면 WHERE 절에 ROW제한조건이 없기때문에 
--dept테이블의 모든 행에 대해 부서명, 위치정보를 수정한다.

--SUBQUERY를 이용한 UPDATE
--emp 테이블에 신규데이터 입력
--사원번호 9999, 사원이름 brown, 업무:null

insert into emp (empno,ename) VALUES (9999,'brown');
commit;

--사원번호가 9999인 사원의 소속부서와 담당업무를 SMITH사원의 부서, 업무로 업데이트하라.
UPDATE emp SET deptno =(select deptno FROM emp WHERE ename = 'SMITH')  , 
                job = (select job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

commit;

--DELETE : 조건에 해당하는 ROW를 삭제
--컬럼의 값을 삭제?? (NULL)값으로 변경하려면 --> UPDATE

--DELETE 테이블명
--[WHERE 조건]

--UPDATE쿼리와 마찬가지로 DELETE 쿼리 실행전에는 해당 테이블을 WHERE 조건으로 동일하게 
--하여 SELECt 를 실행, 삭제될 ROW 를 미리 확인해보자.


--emp 테이블에 존재하는 사원번호 9999인 사원을 삭제
D/ELETE emp
WHERE empno =9999;

SELECT *
FROM emp;

--매니저가 7698인 모든 사원을 삭제
rollback;

DELETE emp
WHERE empno IN(SELECT empno
               FROM emp
               WHERE mgr =7698 );

SELECT *
FROM dept ;

--트렌젝션 level 수정

S-ET TRANSACTION isolation LEVEL SERIALIZABLE;
함부로 사용하지마세요.


--DDL : TABLE 생성
--CREATE TABLE [사용자명.] 테이블명(
--컬럼명1 컬럼타입1,
--컬럼명1 컬럼타입2,...
--컬럼명N 컬럼타입
-- ranger_no NUMBER         : 레인저 번호    
-- ranger_nm VARCHAR2(50)   : 레인저 이름
-- reg_dt DATE              : 레인저 등록일자
--테이블 생성 DDL: Data Defination Language (데이터정의어)
--DDL rollback이 없다.( 자동커밋되므로 rollback을 할 수 없다.)


CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE
    );
    
    
DESC ranger;
SELECT *
FROM ranger;

RollBack;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--WHERE table_name = 'ranger' : 소문자로 작성하면 대문자로 저장되어있어서 검색되지않습니다ㅣ.

INSERT INTO ranger VALUES(1, 'brown', sysdate);
SELECT * FROM ranger;

-DML문은 DDL과 다르게 ROLLBACK이 가능하다.
ROLLBACK;

--Rollback을 했기때문에 ,DML문이 취소됬다.
SELECT *
FROM ranger;


--DATE 타입에서 필드 추출하기
--EXTRACT (필드명 FROM 컬럼/expression)
SELECT to_char(SYSDATE, 'yyyy') yyyy,
       to_CHAR(SYSDATE, 'mm') mm,
       EXTRACT(day FROM sysdate) ex_dd
FROM dual;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    );
    
DROP TABLE dept_test;    

CREATE TABLE dept_test(
    deptno NUMBER(2)PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    );
    
--dept_test 테이블의 deptno컬럼에 PRIMARY KEY제약조건이 있기떄문에
--deptno가 동일한 데이터를 입력하거나 수정 할 수 없다.
--최초데이터이므로 입력성공

INSERT INTO dept_test VALUES(99,'ddit','daejeon');

--dept_test 데이터에 deptno가 99번인 데이터가 있으므로
--primary key 제약조건에 의해 입력될 수 없다.
--ORA-00001 unique constraint 제약위배
--위배되는 제약조건명 SYS-C007106 제약조건 위배)
--sys-coo7106조 제약조건을 어떤 제약조건인지 판단하기 힘드므로
--제약조건에 이름을 코딩 룰에 의해 붙여주는 편이 유지보수시 편하다.

INSERT INTO dept_test VALUES(99,'대덕','대전');

--테이블 삭제후 제약조건 이름을 추가하여 재성성
--primary key : pk_테이블명
DROP TABLE dept_test;    

CREATE TABLE dept_test(
    deptno NUMBER(2)CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    );

--인섵느 구문복사

INSERT INTO dept_test VALUES(99,'ddit','daejeon');
INSERT INTO dept_test VALUES(99,'대덕','대전');