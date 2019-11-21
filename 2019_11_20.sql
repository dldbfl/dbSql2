-- Ư�� ���̺��� �÷� ��ȸ
-- 1. DESC ���̺��
-- 2. SELECT * FROM user_tab_columns;

--prod ���̺��� �÷���ȸ
DESC prod;

VARCHAR2, CHAR --> ���ڿ� (Character)
NUMBER --> ����
CLOB --> Character Large Object, ���ڿ� Ÿ���� ���� ������ ���ϴ� Ÿ��
        -- �ִ� ������ : VARCHAR2(4000), CLOB: 4GB
        
DATE --> ��¥(�Ͻ� = ��,��,�� + �ð�,��,��)

--'2019/11/20 09:16:20' + 1 = 






SELECT * FROM users;


--userid, usernm, reg_dt ��Ű�� Į���� ��ȸ
SELECT userid, usernm, reg_dt
FROM users; 

--userid, usernm, reg_dt ������ �÷��� ��ȸ
--������ ���� ���ο� �÷��� ���� (reg_dt�� ���� ������ �� ���ο� ���� �÷�)
--��¥+��������==> ���ڸ� ���� ��¥Ÿ���� ����� ���´�.
--��Ī: �����÷����̳� ������ ���� ������ �����÷��� ������ �÷��̸��� �ο�
--      col | express [AS] ��Ī��
SELECT userid, usernm, reg_dt, reg_dt+5
FROM users; 

-- ���� ���, ���ڿ� ��� (oracle: '', java,: '', "")
-- table�� ���� ���� ���Ƿ� �÷����� ����
-- ���ڿ� ���� ���� (+.-,/,*)
-- ���ڿ� ���� ���� (+�� ���� ���� ���� ,== ||)
SELECT (10-5)*2, 'DB SQL ����',
        /*userid + '_modified', ���ڿ� ������ ���ϱ� ������ ����*/
        usernm || '_modified', reg_dt
FROM users;

--NULL : ���� �𸣴� ��
--NULL�� ���� ���� ����� �׻� NULL �̴�.
--DESC ���̺�� : NOT NULL�� �����Ǿ�� Į������ ���� �ݵ�� ���� �Ѵ�.

--users ���ʿ��� ������ ����
SELECT
    *
FROM users;

DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony','moon','james');
--���� ��ҹ��ڸ� ������.

rollback;
--�����·� ������
commit;
--Ŀ���ϸ� �ѹ��� �ȵǿ�.


SELECT
    userid, usernm, reg_dt
FROM users;

--null������ �����غ��� ���� moon�� reg_dt �÷��� null�� ����
UPDATE users SET reg_dt = NULL
WHERE userid = 'moon';

rollback;
--�����·� ������
commit;
--Ŀ���ϸ� �ѹ��� �ȵǿ�.

--users ���̺��� reg_dt �÷����� 5���� ���� ���ο� �÷��� ����
--null���� ���� ������ ����� null�̴�.
SELECT userid, usernm, reg_dt, reg_dt+5
FROM users;


---
column alias (�÷� ��Ī�����, alias(��Ī)���鋚 as �ϰ� �ְų� ��ĭ ���� �ۼ�)

--prod ���̺��� prod_id, prod_name ���÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� prod_id-> id, prod_name ->name���� Ŀ�� ��Ī�� ����)
SELECT prod_id id, prod_name name
FROM prod;

--lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� lprod_gu ->gu, lprod_nm-> nm�� �÷� ��Ī�� ����)
SELECT lprod_gu as gu, lprod_nm as nm
FROM lprod;

--buyer ���̺��� buyer_id, buyer_nmae �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�,
--(�� buyer_id -> ���̾���̵�, buyer_name -> �̸����� Ŀ�� ��Ī�� ����)
SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;


--���ڿ� �÷��� ���� (�÷� || �÷�, '���ڿ����' || �÷�)
--                 (CONCAT (�÷�, �÷�) )
SELECT userid, usernm, 
       userid || usernm AS id_nm,
       CONCAT(userid, usernm) con_id_nm,
       -- ||�� �̿��ؼ� userid, usernm, pass
       userid || usernm || pass id_nm_pass,
       -- CONCAT�� �̿��ؼ� userid, usernm, pass
       CONCAT(CONCAT(userid, usernm), pass) con_id_nm_pass
       
FROM users;



SELECT
    *
FROM user_tables;

--���� ������ ����ڰ� ������ ���̺� ����� ��ȸ
--LPROD --> SELECT * FROM LPROD;
SELECT 'SELECT * FROM ' || table_name || ';' query  
FROM user_tables;

--SELECT CONCAT(('SELECT * FROM '),CONCAT(table_name,';')) query
SELECT CONCAT(CONCAT('SELECT * FROM',table_name),';') query
FROM user_tables;

--WHERE : ������ ��ġ�ϴ� �ุ ��ȸ�ϱ� ���� ���
--        �࿡���� ��ȸ ������ �ۼ�
--WHERE���̾����� �ش� ���̺��� ��� �࿡ ���� ��ȸ
SELECT userid, usernm, alias, reg_dt
FROM users
WHERE userid = 'brown'; --userid �÷��� 'brown'�� ��(row)�� ��ȸ


--emp���̺��� ��ü ������ ��ȸ (��� ��(row), ��(column))
SELECT *
FROM emp;

--�μ���ȣ(deptno)�� 20���� ũ�ų� �����μ����� ���ϴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE DEPTNO>=20;

--�����ȣ�� 7700���� ũ�ų� ���� ����� ������ ��ȸ
SELECT *
FROM emp
WHERE empno>=7700;

--����Ի����ڰ� 1982�� 1�� 1�� ������ ��� ���� ��ȸ
--���ڿ�--> ��¥ Ÿ������ ���� TO_DATE('��¥���ڿ�','��¥���ڿ�����')
--�ѱ� ��¥ ǥ�� : ��-��-�� (2020-01-01)
--�̱� ��¥ ǥ�� : ��-��-�� (01-01-2020)
SELECT empno, ename, hiredate,
       2000 no, '���ڿ����' str, TO_DATE('19810101','yyyymmdd') 
FROM emp
WHERE hiredate >= TO_DATE('19820101','YYYYMMDD' );

--���� ��ȸ (BETWEEN ���۱��� AND �������)
--���۱���, ��������� ����
--����߿��� �޿�(SAL)�� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ��� ������ȸ
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--BETWEEN AND �����ڴ� �ε�ȣ �����ڷ� ��ü ����
SELECT
    *
FROM emp
WHERE sal >= 1000
AND   sal <= 2000;

-- emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
-- �� �����ڴ� between�� ����Ѵ�.

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','yyyymmdd') AND 
                       TO_DATE('19830101','yyyymmdd'); 
                       
--where2
SELECT ename, hiredate    
FROM emp
WHERE hiredate >= TO_DATE('19820101','yyyymmdd') 
AND   hiredate <= TO_DATE('19830101','yyyymmdd');