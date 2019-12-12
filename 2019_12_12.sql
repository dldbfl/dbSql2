--��Ī: ���̺�, �÷��� �ٸ� �̸����� ��Ī
-- [AS] ��Ī��
-- select empno [as] eno
-- from emp e

--SYNONYM (���Ǿ�)
--����Ŭ ��ü�� �ٸ� �̸����� �θ� �� �ֵ��� �ϴ� ��
--���࿡ emp ���̺��� e ��� �ϴ� ���Ǿ�(synonym)�� ������ �ϸ�
-- ������ ���� SQL�� �ۼ��� �� �ִ�.
-- SELECT *
-- FROM e;

--pc03������ synonym ���� ������ �ο�
GRANT CREATE synonym TO PC03;

--emp ���̺��� ����Ͽ� synonym e�� ����
--create synonym �ó�� �̸� for ����Ŭ ��ü;
CREATE SYNONYM e FOR emp;

--emp ��� ���̺� �� ��ſ� e ����ϴ� �ó���� ����Ͽ� ������ �ۼ�
--�� �� �ִ�.
SELECT *
FROM e;

--pc03������ fastfood ���̺��� hr ���������� �� �� �ֵ���
--���̺� ��ȸ ������ �ο�
GRANT SELECT ON fastfood TO hr;


SELECT*
FROM dictionary;

SELECT *
FROM USER_SYNONYMS;

SELECT *
FROM USER_ind_columns;

--������ SQL�� ���信 ������ �Ʒ� SQL���� �ٸ���.
SELECT /* 201911_205 */ * FROM emp;
SELECT /* 201911_205 */ * FROM EMP;
select /* 201911_205 */ * from emp;

SELECT * FROM V$SQL
WHERE SQL_TEXT LIKE '%201911_205%';

--multiple insert 
DROP TABLE emp_test;

--emp ���̺��� empno, ename �÷����� emp_test, emp_test2 ���̺���
--����(CTAS, �����͵� ���� ����)
CREATE TABLE emp_test AS 
    SELECT empno, ename
    FROM emp;

CREATE TABLE emp_test_2 AS 
    SELECT empno, ename
    FROM emp;    

--uncoditional insert
--���� ���̺� �����͸� ���� �Է�
--brown,cony �����͸� emp_test, emp_test2 ���̺� ���� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test_2
SELECT 9999,'brown' FROM DUAL UNION ALL
SELECT 9998,'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000;


rollback;
--���̺� �� �ԷµǴ� �������� �÷��� �����.

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
--���ǿ� ���� ���̺� �����͸� �Է�

/*
    CASE
        WHEN ���� THEN ----   //IF
        WHEN ���� THEN ----   //ELSE IF
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
