SELECT * FROM emp_test
ORDER BY EMPNO;

--emp ���̺� �����ϴ� �����͸� emp_test ���̺�� ����
--���� empno �� ������ �����Ͱ� �����ϸ�
--ename update : ename || '_merge'
--���� empno�� ������ �����Ͱ� �������� ���� ���
--emp���̺��� empno, ename emp_test �����ͷ� insert

--emp_test �����Ϳ��� ������ �����͸� ����
DELETE EMP_TEST
WHERE EMPNO>=7788;
commit;

--emp ���̺��� 14���� �����Ͱ� ����
--emp_test ���̺��� ����� 7788���� ���� 7���� �����Ͱ� ����
--emp ���̺��� �̿��Ͽ� emp_test ���̺��� �����ϰ� �Ǹ�
--emp ���̺��� �����ϴ� ���� (����� 7788���� ũ�ų� ���� ����) 7��
--emp_test�� ���Ӱ� insert�� �� ���̰�
--emp, emp_test �����ȣ�� �����ϰ� �����ϴ� 7���� �����ʹ� 
--(����� 7788���� ���� ����) ename �÷��� enmae || '_modify'��
--������Ʈ�� �Ѵ�.

/*
MERGE INTO ���̺��
USING ������� ���̺�|VIEW|SUBQUERY
ON (���̺��� ��������� �������)
WHEN MATCHED THEN
    UPDATE .....
WHEN NOT MATCHED THEN 
    INSERT....
*/

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES(emp.empno, emp.ename);



-- emp_test ���̺� ����� 9999�� �����Ͱ� �����ϸ�
--ename�� 'brown'���� update
--������������ ��� empno, ename VALUES (9999,'brown') ���� insert
--���� �ó������� MERGE ������ Ȱ���Ͽ� �ѹ��� sql�� ����
MERGE INTO emp_test
USING dual
ON (emp_test.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = : ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (: empno, : ename);
    
--���� merge ������ ���ٸ�
--1. empno = 9999�� �����Ͱ� �����ϴ��� Ȯ��
--2-1. 1�����׿��� �����Ͱ� �����ϸ� UPDATE
--2-2. 1�����׿��� �����Ͱ� �������������� INSERT

SELECT deptno, sum(sal)
FROM emp
GROUP BY deptno
union 
SELECT null ,sum(sal)
FROM emp;

--join ������� Ǯ��
--emp ���̺��� 14�ǿ� �����͸� 28������ ����
--������ (1-14, 2-14)�� �������� group by
--������ 1 : �μ���ȣ �������� 14row
--������ 2 : ��ü 14 row

SELECT DECODE(b.rn, 1, emp.deptno , 2,null) deptno, 
        sum(emp.sal) sal
        
FROM emp,(SELECT ROWNUM rn
          FROM dept
          WHERE ROWNUM <=2) b
          
GROUP BY DECODE(b.rn, 1, emp.deptno , 2,null)
ORDER BY DECODE(b.rn, 1, emp.deptno , 2,null);

--

SELECT DECODE(b.rn, 1, emp.deptno , 2,null) deptno, 
        sum(emp.sal) sal

FROM emp,(SELECT LEVEL rn
          FROM dual
          CONNECT BY LEVEL <=2) b
          
GROUP BY DECODE(b.rn, 1, emp.deptno , 2,null)
ORDER BY DECODE(b.rn, 1, emp.deptno , 2,null);

--REPORT GROUP BY 
--ROLLUP
--GROUP BY ROLLUP(col1....)
--ROLLUP ���� ����� �÷��� �����ʿ������� ���� �����
--SUB GROUP�� �����Ͽ� �������� GROUP BY ���� �ϳ��� SQL���� ����ǵ��� �Ѵ�.

--ROLLUP�� �÷� ������ ��ȸ ����� ������ ��ģ��.
GROUP BY ROLLUP (job, deptno)
--group by job, deptno
--group by job
--group by --> ��ü�� ������� group by 

--emp ���̺��� �̿��Ͽ� �μ���ȣ�� , ��ü�������� �޿����� ���ϴ� ������ 
--rollup ����� �̿��Ͽ� �ۼ��϶�

SELECT deptno, sum(sal) sal
from emp
GROUP BY ROLLUP (deptno);

--emp ���̺��� �̿��ؼ� job, deptno �� sal+ comm�հ�
--                    job �� sal_comm �հ�
--                    ��ü������ sal_comm �հ�
--rollup�� ����Ͽ� �ۼ�

SELECT job, deptno, sum(sal+NVL(comm,0))
FROm emp
GROUP BY ROLLUP (job, deptno);
--group by job, deptno
--group by job
--group by --> ��ü�� ������� group by 


SELECT job, deptno, sum(sal+NVL(comm,0))sal
FROm emp
GROUP BY job, deptno UNION ALL

SELECT job, null,
         sum(sal+NVL(comm,0))sal
FROm emp
GROUP BY job UNION ALL 

SELECT null, null, 
        sum(sal+NVL(comm,0))sal
FROm emp;


--group by rollup function---

SELECT NVL(job, '�Ѱ�'), deptno, sum(sal+NVL(comm,0)) sal
FROm emp
GROUP BY ROLLUP (job, deptno);

---

SELECT DECODE(GROUPING(job),1, '�Ѱ�',job) job, deptno, sum(sal+NVL(comm,0)) sal
FROm emp
GROUP BY ROLLUP (job, deptno);

--ad2_2
--�������--�Ұ����ҰŰ���.
SELECT DECODE(GROUPING(job),1, '��',job) job, 
       DECODE(GROUPING(job),0, DECOD0E(b.gpb,1,'�Ұ�',deptno),1,
                               DECODE(b.gpb,1,'��',deptno)), sal
FROM emp ,(SELECT DECODE(GROUPING(job),1, '��',job) job, deptno,GROUPING(deptno)gpb, sum(sal+NVL(comm,0)) sal
           FROm emp
           GROUP BY ROLLUP (deptno,job))b

GROUP BY ROLLUP (job,deptno);

SELECT DECODE(GROUPING(job),1, '��',job) job, 
       DECODE(GROUPING(job),0, DECODE(GROUPING(deptno),1, '�Ұ�',deptno),
                            1, DECODE(GROUPING(deptno),1, '��',deptno)) deptno , sum(sal+NVL(comm,0)) sal 
 
FROM emp 
GROUP BY ROLLUP (job,deptno);
--�����Բ�
SELECT job, deptno, DECODE(GROUPIng(job),1,'��',job) job,
       CASE
           WHEN deptno IS NULL AND job IS NULL THEN '��'
           WHEN deptno IS NULL AND job IS NOT NULL THEN '�Ұ�'
           ELSE '' || deptno
       END,
       sum(sal+NVL(comm,0)) sal 
 
FROM emp 
GROUP BY ROLLUP (job,deptno);
      
SELECT DECODE(GROUPING(job),1, '��',job) job, deptno,GROUPING(deptno), sum(sal+NVL(comm,0)) sal
FROm emp
GROUP BY ROLLUP (deptno,job);

--group ad3--
SELECT deptno, job, sum(sal+NVL(comm,0)) sal
FROm emp
GROUP BY ROLLUP (deptno,job)
ORDER BY deptno;

--UNION ALL �� ġȯ
SELECT deptno, job, SUM (sal+NVL(comm,0)) sal_sum
FROM emp
GROUP BY deptno, job

UNION ALL

SELECT deptno, null,SUM (sal+NVL(comm,0)) sal_sum
From EMP
GROUP by deptno;





--group ad4--

SELECT dname, job, sum(sal+NVL(comm,0)) sal
FROm emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname,job)
ORDER BY dname, job DESC;

select * from DEPT;
SELECT * FROM emp;
 ----------------------
SELECT dept.dname, a.job, a.sal
FROM
    (SELECT deptno, job, sum(sal+NVL(comm,0)) sal
     FROm emp
     GROUP BY ROLLUP (deptno,job))a, dept
WHERE a.deptno = dept.deptno(+);

ORDER BY dname, job DESC;

select * from DEPT;
SELECT * FROM emp;





--group ad 5-- 

SELECT DECODE(GROUPING(dname),1,'�Ѱ�',dname) dname ,job, sum(sal+NVL(comm,0)) sal
FROm emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname,job)
ORDER BY dname, job DESC;

