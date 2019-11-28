
--join     a.c = b.c c�� ����� a,b �ΰ����� ȥ��. 
--emp ���̺�, dept ���̺� ����

EXPLAIN PLAN FOR
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT ename, deptno 
FROM emp;

SELECT deptno, dname 
FROM dept;

SELECT *
FROM TABLE (DBMS_XPLAN.DISPLAY);
-- "���ʿ������� �а�, ������ ���� �д´�.( �ؿ��� ��ȣ 2-3-1-0������ ����) 2,3�� ���� ������ 1���� �ڽ� ���۷��̼�


SELECT ename, emp.deptno, dept.dname
FROM emp,dept
WHERE emp.deptno != dept.deptno
AND emp.deptno=10;

--natural join : �������̺� ���� Ÿ��, ���� �̸��� �÷�����
--               ���� ���� ���� ��� ����

--ANSI SQL
SELECT deptno , emp.empno, ename
FROM emp NATURAL JOIN dept;

--oracle ����
SELECT emp.deptno, emp.empno, ename
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--JOIN USING
--join �Ϸ��� �ϴ� ���̺� �� ������ �̸��� �÷��� �ΰ� �̻��� ��
--join �÷��� �ϳ��� ����ϰ� ���� ��

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);
--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;
--ANSI JOIN with ON 
--���� �ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ� ��
--�����ڰ� ���� ������ ���� ������ ��
--ANSI sql
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);
--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺� ����
--emp ���̺� ���� �Ҹ��� ���� : ������ ������ ���� ��ȸ
--������ ������ ������ ��ȸ
--���� �̸�, ������ �̸�
--���� �̸�, ������ ����� �̸�, ������ ����� �̸�

--ANSI sql
SELECT e.ename, m.ename, u.ename, q.ename
FROM emp e JOIN emp m ON e.mgr = m.empno JOIN emp u ON m.mgr = u.empno JOIN emp q ON u.mgr = q.empno;
--ORACLE SQL
SELECT e.ename, m.ename, u.ename, q.ename
FROM emp e, emp m, emp u, emp q
WHERE e.mgr = m.empno AND m.mgr = u.empno AND u.mgr = q.empno;

--dept 4* 4* 4
SELECT *
FROM dept s, dept a, dept c;

--���� ���̺��� �̿��� ANSI JOIN�� �̿��� JOIN
SELECT e.ename, m.ename, t.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
           JOIN emp t ON (m.mgr = t. empno);

--������ �̸���, �ش� ������ ������ �̸��� ��ȸ�Ѵ�.
--�� ������ ����� 7369~7698�� ������ ������� ��ȸ

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON e.mgr = m.empno
WHERE e.empno BETWEEN 7369 AND 7698;

SELECT e.ename, m.ename
FROM emp e JOIN emp m ON e.mgr = m.empno
WHERE e.empno >= 7369 
AND e.empno <= 7698;


--NON -EQUI JOIN ���������� =(equai)�� �ƴ� �ֵ�
--!=, BETWEEN AND



SELECT *
FROM salgrade;

SELECT empno, ename, sal ,salgrade.grade
FROM emp JOIN salgrade ON emp.sal BETWEEN salgrade.Losal AND salgrade.hisal;
          

SELECT empno, ename, sal ,salgrade.grade
FROM emp JOIN salgrade ON emp.sal >= salgrade.Losal 
                       AND emp.sal <= salgrade.hisal;
                       

--�ǽ� join0

SELECT *
FROM emp;

SELECT empno, ename, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno;


SELECT empno, ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER by deptno;

--�ǽ� join0_1

SELECT empno, ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND dept.deptno IN (10, 30)
ORDER by empno;

SELECT empno, ename, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND dept.deptno IN (10, 30)
ORDER by empno;

--�ǽ� join0_2

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal > 2500
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 2500
ORDER by deptno;



--�ǽ� join0_3


SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500
AND empno > 7600
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno AND emp.sal > 2500 AND empno > 7600
ORDER by deptno;


-- �ǽ� join0_4

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal > 2500
AND empno > 7600
AND DNAME = 'RESEARCH'
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.deptno = dept.deptno 
                    AND emp.sal > 2500 
                    AND empno > 7600 
                    AND DNAME = 'RESEARCH'
ORDER by deptno;


--�ǽ� join 1
SELECT *
FROM prod;
SELECT *
FROM LPROD;

SELECT LPROD_GU, LPROD_NM, PROD_ID, PROD_NAME
FROM prod, lprod
WHERE PROD_LGU = LPROD_GU
ORDER BY prod_id;