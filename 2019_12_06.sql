select * from dept;

--dept ���̺� �μ���ȣ 99 �μ��� ddit ��ġ daejeon

INSERT into dept
values(99, 'ddit', 'daejeon') ;

rollback;

commit;

--UPDATE : ���̺� ����� �÷��� ���� ����
--UBDATE ���̺�� SET  �÷���1= �����Ϸ����ϴ� ��1, �÷���=�����Ϸ����ϴ°�2....)
--[WHERE row ��ȸ ����] -- ��ȸ���ǿ� �ش��ϴ� �����͸� ������Ʈ�ȴ�.

--�μ���ȣ�� 99���� �μ��� �μ����� ���IT�� , ������ ���κ������� ����

UPDATE dept SET DNAME = '���IT', LOC = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;
--������Ʈ ���� ������Ʈ �Ϸ��� �ϴ� ���̺��� WHERE���� ����� �������� SELECT �Ͽ� 
--������Ʈ ��� ROW �� Ȯ���غ���

SELECT *
FROM dept
WHERE deptno= 99;

UPDATE dept SET DNAME = '���IT', LOC = '���κ���';
--���� QUERY�� �����ϸ� WHERE ���� ROW���������� ���⶧���� 
--dept���̺��� ��� �࿡ ���� �μ���, ��ġ������ �����Ѵ�.

--SUBQUERY�� �̿��� UPDATE
--emp ���̺� �űԵ����� �Է�
--�����ȣ 9999, ����̸� brown, ����:null

insert into emp (empno,ename) VALUES (9999,'brown');
commit;

--�����ȣ�� 9999�� ����� �ҼӺμ��� �������� SMITH����� �μ�, ������ ������Ʈ�϶�.
UPDATE emp SET deptno =(select deptno FROM emp WHERE ename = 'SMITH')  , 
                job = (select job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

commit;

--DELETE : ���ǿ� �ش��ϴ� ROW�� ����
--�÷��� ���� ����?? (NULL)������ �����Ϸ��� --> UPDATE

--DELETE ���̺��
--[WHERE ����]

--UPDATE������ ���������� DELETE ���� ���������� �ش� ���̺��� WHERE �������� �����ϰ� 
--�Ͽ� SELECt �� ����, ������ ROW �� �̸� Ȯ���غ���.


--emp ���̺� �����ϴ� �����ȣ 9999�� ����� ����
D/ELETE emp
WHERE empno =9999;

SELECT *
FROM emp;

--�Ŵ����� 7698�� ��� ����� ����
rollback;

DELETE emp
WHERE empno IN(SELECT empno
               FROM emp
               WHERE mgr =7698 );

SELECT *
FROM dept ;

--Ʈ������ level ����

S-ET TRANSACTION isolation LEVEL SERIALIZABLE;
�Ժη� �������������.


--DDL : TABLE ����
--CREATE TABLE [����ڸ�.] ���̺��(
--�÷���1 �÷�Ÿ��1,
--�÷���1 �÷�Ÿ��2,...
--�÷���N �÷�Ÿ��
-- ranger_no NUMBER         : ������ ��ȣ    
-- ranger_nm VARCHAR2(50)   : ������ �̸�
-- reg_dt DATE              : ������ �������
--���̺� ���� DDL: Data Defination Language (���������Ǿ�)
--DDL rollback�� ����.( �ڵ�Ŀ�ԵǹǷ� rollback�� �� �� ����.)


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
--WHERE table_name = 'ranger' : �ҹ��ڷ� �ۼ��ϸ� �빮�ڷ� ����Ǿ��־ �˻������ʽ��ϴ٤�.

INSERT INTO ranger VALUES(1, 'brown', sysdate);
SELECT * FROM ranger;

-DML���� DDL�� �ٸ��� ROLLBACK�� �����ϴ�.
ROLLBACK;

--Rollback�� �߱⶧���� ,DML���� ��҉��.
SELECT *
FROM ranger;


--DATE Ÿ�Կ��� �ʵ� �����ϱ�
--EXTRACT (�ʵ�� FROM �÷�/expression)
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
    
--dept_test ���̺��� deptno�÷��� PRIMARY KEY���������� �ֱ⋚����
--deptno�� ������ �����͸� �Է��ϰų� ���� �� �� ����.
--���ʵ������̹Ƿ� �Է¼���

INSERT INTO dept_test VALUES(99,'ddit','daejeon');

--dept_test �����Ϳ� deptno�� 99���� �����Ͱ� �����Ƿ�
--primary key �������ǿ� ���� �Էµ� �� ����.
--ORA-00001 unique constraint ��������
--����Ǵ� �������Ǹ� SYS-C007106 �������� ����)
--sys-coo7106�� ���������� � ������������ �Ǵ��ϱ� ����Ƿ�
--�������ǿ� �̸��� �ڵ� �꿡 ���� �ٿ��ִ� ���� ���������� ���ϴ�.

INSERT INTO dept_test VALUES(99,'���','����');

--���̺� ������ �������� �̸��� �߰��Ͽ� �缺��
--primary key : pk_���̺��
DROP TABLE dept_test;    

CREATE TABLE dept_test(
    deptno NUMBER(2)CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
    );

--�ΙD�� ��������

INSERT INTO dept_test VALUES(99,'ddit','daejeon');
INSERT INTO dept_test VALUES(99,'���','����');