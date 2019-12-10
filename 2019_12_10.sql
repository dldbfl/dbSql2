--�������� Ȱ��ȭ;/ ��Ȱ��ȭ
--ALTER TABLE ���̺�� ENABLE OR DISABLE �������Ǹ�;

--USER_CONSTRAINTS view�� ���� dept_test ���̺� ������ �������� Ȯ��

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

ALTER TABLE dept_test DISABLE CONSTRAINT SYS_C007131;

SELECT * FROM dept_test;

--dept_test ���̺��� deptno �÷��� ����� PRIMARY KEY ���������� ��Ȱ��ȭ �Ͽ� 
--������ �μ���ȣ�� ���� �����͸� �Է��Ҽ� �ִ�.
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO dept_test VALUES (99,'DDIT','����');

--dept_test ���̺��� PRIMARY KEY �������� Ȱ��ȭ
--�̹� ������ ������ �ΰ��� INSERT ������ ���� ���� �μ���ȣ�� ���� �����Ͱ�
--�����ϱ� ������ PRIMARY KEY ���������� Ȱ��ȭ �� �� ����.
--Ȱ��ȭ �Ϸ��� �ߺ������͸� ���� �ؾ��Ѵ�.
ALTER TABLE dept_test ENABLE CONSTRAINT SYS_C007131;

--�μ���ȣ�� �ߺ��Ǵ� �����͸� ��ȸ�Ͽ�
--�ش� �����Ϳ� ���� ���� �� PRIMARY KEY ���������� Ȱ��ȭ �� �� �ִ�.
SELECT
    deptno, COUNT(*)
FROM dept_test
GROUP BY deptno
HAVING COUNT (*) >=2;

--talbe_name, constraints_name, column_name
--position ����(ASC)

SELECT*
FROM user_constraints
WHERE table_name = 'BUYER';

SELECT*
FROM user_cons_columns
WHERE table_name= 'BUYER';

--���̺� ���� ����(�ּ�) VIEW
SELECT *
FROM USER_TAB_COMMENTS;
SELECT *
FROM USER_COL_COMMENTS;

--���̺� �ּ�
--COMMENT ON TABLE ���̺�� IS '�ּ�';
COMMENT ON TABLE dept IS '�μ�';

--�÷� �ּ�
--COMMENT ON COLUMN ���̺�.�÷��� IS '�ּ�';
COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ ����';

--�ǽ� comment1

--user_tab_comments, user_col_comments view�� �̿��Ͽ� 
--customer, product, cycle, daily ���̺�� �÷��� �ּ������� ��ȸ�ϴ� ������ �ۼ��ϸ���
SELECT a.TABLE_NAME,TABLE_TYPE,a.comments tab_commets, b.COLUMN_NAME, b.COMMENTS col_commets
FROM USER_TAB_COMMENTS a, USER_COL_COMMENTS b
WHERE a. TABLE_NAME = b. table_name
AND a.table_name IN ('CUSTOMER', 'PRODUCT','CYCLE','DAILY');

SELECT
    *
FROM user_tab_comments;

--VIEW : QUERY�� �����̴�.(O)
--���̺�ó�� �����Ͱ� ���������� �����ϴ� ���� �ƴϿܴ�.
--���� ������ �� = QUERY
--VIEW�� ���̺��̴�(X)

--VIEW ����
--CREATE OR REPLACE VIEW ���̸� [(�÷���Ī1, �÷���Ī2...)] AS
--SUBQUERY

--emp���̺��� sal, comm�÷��� ������ ������ 6�� �÷��� ��ȸ���Ǵ� view
--v_emp�̸����� ����

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;


--SYSTEM �������� �۾�
--VIEW ���� ������ PC03���� �ο�
GRANT CREATE VIEW TO PC03;

SELECT *
FROM v_emp;

--INLINE VIEW
SELECT
    *
FROM(SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp);

--emp ���̺��� �����ϸ� view�� ������ ����?
--KING�� �μ���ȣ�� ���� 10��
--emp ���̺��� KING�� �μ���ȣ �����͸� 30������ ����(COMMIT)
--v_emp ���̺��� KING�� �μ���ȣ�� ����

UPDATE emp SET deptno = 30

SELECT *
FROM emp
WHERE ename = 'KING';

rollback;

--���ε� ����� view�� ����
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno eno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM V_EMP_DEPT;

--emp �Ĥ��̺��� king ������ ����(commit ��������)
DELETE emp
WHERE ename = 'KING';

rollback;
--emp ���̺��� empno�÷��� eno�� �÷��̸� ����
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


-- �μ��� ������ �޿� �հ�
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
--ORACLE��ü�� �ߺ������ʴ� �������� �������ִ� ��ü
--cREATE SEQUENCE ��������
--[�ɼ�...]

CREATE SEQUENCE seq_board;
DROP SEQUENCE seq_board;

--������ ����� : ��������.nextval
--������-����
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

--emp ���̺� empno �÷����� PRIMARY KEY ���� ����: pk_emp
--dept ���̺� deptno �÷����� PRIMARY KEY ���� ����: pk_dept
--emp ���̺��� empno�÷��� dept���̺��� deptno�÷��� �����ϵ���
--FOREIGN KEYT ���� �߰� : fk_dept_deptno

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEy(empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEy(deptno);
ALTER TABLE emp ADD CONSTRAINT fk_dept_deptno FOREIGN KEY(deptno)
            REFERENCES dept (deptno);
            
--emp_test ���̺� ����
DROP TABLE emp_test;

--emp ���̺��� �̿��Ͽ� emp_test ���̺� ����
CREATE TABLE emp_test As 
SELECT *
FROM emp;