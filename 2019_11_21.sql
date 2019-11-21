--col IN (valuel, value2...)
--col�� ���� IN ������ �ȿ� ������ �� �߿� ���Ե� �� ������ ����

--RDBMS - ���հ���
--1.���տ��� ������ ����.
--{1,5,7}, {5,1,7}

--2.���տ��� �ߺ��� ����.
--{1,1,5,7}, {5,1,7}
SELECT *
FROM emp
WHERE deptno IN (10, 20); --emp ���̺��� ������ �Ҽ� �μ��� 10���̰ų� 20���� ���������� ��ȸ

--�̰ų�  --> or(�Ǵ�)
--�̰�    --> AND(�׸���)

-- IN --> OR
-- BETWEEN AND --> AND + �����

SELECT *
FROM emp
WHERE deptno = 10 or deptno = 20;


--where 3

SELECT userid ���̵�, usernm �̸�, alias ����
FROM users
WHERE userid IN ('brown', 'cony', 'sally');


DESC users;
SELECT *
FROM users;

--LIKE ������ : ���ڿ� ��Ī ����
-- % : ���� ���� (���ڰ� ���� ���� �ִ�.)
-- _ : �ϳ��� ����

--emp���̺��� ��� �̸�(ename)�� s�� �����ϴ� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--SMITH 
--SCOTT
--ù���ڴ� s�� �����ϰ� 4��° ���ڴ� T
--�ι�°, ����°, �ټ���° ���ڴ� � ���ڵ� �� �� �ִ�.

SELECT *
FROM emp
WHERE ename LIKE 'S__T_';

SELECT *
FROM emp
WHERE ename LIKE '___T_';

--where 4
--member ���̺��� ȸ���� ���� [��]���� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';
--member ���̺��� ȸ���� �̸��� [��]���� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

--�÷� ���� NULL�� ������ ã��
--emp ���̺� ���� MGR �÷��� NULL �����Ͱ� ����

SELECT *
FROM emp
WHERE MGR IS NULL;  -- NULL �� Ȯ�ο��� IS NULL �����ڸ� ���
WHERE MGR = 7698;   -- MGR �÷� ���� 7698�� ��� ������ȸ
WHERE MGR = NULL;   -- MGR �÷� ���� NULL�� ��� ������ȸ

--where 6
--emp ���̺��� ��(comm)�� �ִ� ȸ���� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��Ͻÿ�

update emp 
SET comm = 0
WHERE empno = 7844;
commit;

SELECT *
FROM emp
WHERE comm IS NOT NULL;

--AND : ������ ���ÿ� ����
--OR : ������ �Ѱ��� �����ϸ� ����
SELECT *
FROM emp
WHERE mgr=7698
AND sal > 1000;

--emp ���̺��� mgr�� 7698 �̰ų� (or) , �޿��� 1000���� ū ���
SELECT * 
FROM emp
WHERE mgr=7698
OR sal > 1000;

--emp���̺��� ������ ����� 7698, 7839�� �ƴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839) OR mgr IS NULL ; --NULL ���� ���ԵǾ������� IS NOT NULL�� ������

--WHERE 7
-- emp ���̺��� job�� SLAESMAN�̰� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���.
SELECT *
FROM emp
WHERE job IN 'SALESMAN' AND HIREDATE > to_date('19810601','yyyymmdd');