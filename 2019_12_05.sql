INSERT INTO dept VALUES (99,'ddit','daejeon');

rollback;


SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

-- dept <> 40;  dept �� 40�� �ƴѰ�                    
                    
                    
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
--cid=2�� ���� �����ϴ� ��ǰ�� cid = 1�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ

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
                 
                 
--�Ŵ����� �����ϴ� ���� ���� ��ȸ                 
SELECT *
FROM emp a 
WHERE EXISTS(SELECT 1
            FROM emp b
            WHERE b.empno = a.mgr);
 
--SUB 8 EXISTS ������ �ǽ�

SELECT a.*
FROM emp a, emp b
WHERE b.empno = a.mgr;

SELECT *
FROM emp
WHERE mgr IS NOT NULL;


--sub 9 ����ȣ exists

SELECT product.pid, pnm
FROM product
WHERE NOT EXISTS (SELECT 1
                  FROM cycle
                  WHERE cid=1
                  AND cycle.pid = product.pid);


--sub 10 ����ȣ exists

SELECT product.pid, pnm
FROM product
WHERE  EXISTS (SELECT 1
               FROM cycle
               WHERE cid=1
               AND cycle.pid = product.pid);
               

-- ���տ���
--UNION : ������, �� ������ �ߺ����� �����Ѵ�.
--�������� SALESMAN�� ������ ������ȣ, ���� �̸� ��ȸ
--�� �Ʒ� ������� �����ϱ� ������ ������ ������ �ϰ� �ɰ��
--�ߺ��Ǵ� �����ʹ� �ѹ��� ǥ���Ѵ�.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���� �ٸ� ������ ������
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'CLERK';

--UNION ALL
--������ ����� �ߺ� ���Ÿ� ���� �ʴ´�.
--���Ʒ� ��� ���� �ٿ� �ֱ⸸ �Ѵ�.
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���տ���� ���ռ��� �÷��� ���� �ؾ��Ѵ�.
--�÷��� ������ �ٸ���� ������ ���� �ִ� ������� ������ �����ش�.
SELECT empno, ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN';

-- INTERSECT : ������
--�� ���հ� �������� �����͸� ��ȸ
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--MINUS
--������ : ��, �Ʒ� ������ �������� �� ���տ��� ������ ������ ��ȸ
--�������� ��� ������, �����հ� �ٸ��� ������ ���� ������ ��� ���տ� ������ �ش�.
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--ORDER BY ����

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
-- INSERT : ���̺� ���ο� �����͸� �Է�
select * from dept;

--INSERT �� �÷��� ������ ���
--������ �÷��� ���� �Է��� ���� ������ ������ ����Ѵ�.
--INSERT INTO ���̺�� (�÷�1, �÷�2....)
--              VALUES (��1, ��2....)
--dept ���̺� 99�� �μ���ȣ, ddit ������, daejoen �̶�� �������� ���� �����͸� �Է��غ���.
select * from dept;
INSERT INTO dept (deptno, dname, loc)
            VALUES (99, 'ddit', 'daejeon');

--�÷��� ����� ��� ���̺��� �÷� ���� ������ �ٸ��� �����ص� ����� ����.
--dept ���̺��� �÷� ���� : deptno, dname, location
INSERT INTO dept (loc, deptno, dname)
            VALUES ('daejeon', '99', 'ddit');
            
--�÷��� ������� �ʴ°�� : ���̺��� �÷� ���� ������ ���� ���� ����Ѵ�.
desc dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
            
--��¥ �� �Է��ϱ�
--1. SYSDATE
--2. ����ڷ� ���� ���� ���ڿ��� DATE Ÿ������ �����Ͽ� �Է�
SELECT * FROM emp;
desc emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);
select * from emp WHERE empno = 9998;

--2019�� 12�� 2�� �Ի�
INSERT INTO emp VALUES (9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'yyyymmdd'), 500, NULL, NULL);
select * from emp WHERE empno = 9997;

--�������� �����͸� �ѹ��� �Է�
--SELECT ����� ���̺� �Է� �� �� �ִ�.
-- ���Ͽ�Ȱ���Ͽ� INSERT �Ҽ��� ����.
INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500,NULL, NULL 
FROM dual
UNION ALL
SELECT 9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'yyyymmdd'), 500, NULL, NULL
FROM dual;

select * from emp where empno in(9998, 9997);

rollback
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            