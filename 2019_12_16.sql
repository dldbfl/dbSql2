--GROUPING SETS(col1, col2)
--������ ����� ����
--�����ڰ� GROUP BY �� ������ ���� ����Ѵ�
--ROLLUP���� �޸� ���⼺�� ���� �ʴ´�
--GROUPING SET(col1. col2) = GROUPING SETS(col2.col1)

--GROUP BY col1
--UNION ALL
--GROUP BY col2

--GROUP BY col2
--UNION ALL
--GROUP BY col1

--emp ���̺��� ������ job(����)�� �޿� (sal)+��(comm)��,
--                    deptno(�μ�, �޿�(sal), + ��(comm) ��
--������� (GROUP FUNCTION) : 2���� sql �ۼ� �ʿ�(UNION/ UNION ALL)

SELECT job ,null deptno, sum (sal+NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY job
UNION ALL
SELECT '', deptno, sum(sal+NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY deptno;

--GROUPING SETS ������ �̿��Ͽ� ���� SQL�� ���տ����� ������� �ʰ�
--���̺��� �ѹ� �о ó��
SELECT job, deptno, SUM(sal+NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);


--job, deptno�� �׷����� �� sal_comm ��
--mgr�� �׷����� �� sal+comm��
--gROUP BY job, deptno 
--UNION ALL
--GROUP BY mgr
-- --> GROUPING SETS ((job, deptno), mgr)
--null������ üũ�ϸ� ���ΰ��� �ƴҼ����ִ�. �׷��� grouping�� ����
SELECT job ,deptno ,mgr,  sum(sal+NVL(comm,0)) sal_comm_sum,
        GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETs ((job,deptno),mgr);


--CUBE( col1, col2, ...)
-- ������ �÷��� ��� ������ �������� GROUP BY subset�� �����
-- CUBE�� ������ �÷��� 2���� ��� : ������ ���� 4��
-- CUBE�� ������ �÷��� 3���� ��� : ������ ���� 8��
-- CUBE�� ������ �÷����� 2�� ������ ����� ������ ���� ������ �ȴ� (2^n)
--�÷��� ���ݸ� �������� ������ ������ ���ϱ޼������� �þ�� ������
--���� ��������� �ʴ´�.

-- job, deptno�� �̿��Ͽ� CUBE ����
SELECT job, deptno, SUM (sal+NVL(comm,0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
--job, deptno
--1,    1   --> GROUP BY job, depntno
--1,    0   --> GROUP BY job
--0,    1   --> GROUP BY depntno
--0,    0   --> GROUP BY --emp���̺��� ����࿡ ���� group by

--GROUP BY ����
--GROUP BY , ROLLUP,CUBE�� ���� ����ϱ�
--������ ������ �����غ��� ���� ����� ������ �� �ִ�.
--GROUP BY JOB, rollup( deptno), cube(mgr)

SELECT job, deptno,mgr,SUM (sal+NVL(comm,0)) sal_comm_sum,
            Grouping(job),Grouping(deptno),Grouping(mgr)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

--

SELECT job, job, sum(sal)
FROM emp
GROUP BY job,job;

select *
from dept_test;

--subqurey_ sub_a1

DROP TABLE dept_test;

CREATE TABLE dept_test AS SELECT* 
                          FROM dept;
                          
SELECT * fROM dept_test;

ALTER TABLE dept_test ADD(empcnt number);

-- ù������ �ȵ�
UPDATE dept_test
SET empcnt = (SELECT count(dept.deptno)
              FROM emp,dept
              WHERE emp.deptno = dept.deptno
              group by emp.deptno)
              ;
              
UPDATE dept_test
SET empcnt = (SELECT count(deptno)
              FROM emp
              WHERE emp.deptno = dept_test.deptno);
   

SELECT * fROM dept_test;


--sub_a2
DROP TABLE dept_test;

CREATE TABLE dept_test AS SELECT* 
                          FROM dept;
                          
insert into dept_test values(99, 'it1', 'daejeon');
insert into dept_test values(98, 'it2', 'daejeon');

select *
FROM dept_test;

DELETE FROM dept_test
WHERE deptno NOT IN (SELECT dept_test.deptno
                     FROM emp
                     WHERE dept_test.deptno = emp.deptno);
                     
DELETE FROM dept_test
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                    );                                

--�������� ADVANCED (correlated subquery delete - �ǽ� sub_a3)

DROP TABLE emp_test;

CREATE TABLE emp_test AS SELECT* 
                          FROM emp;
                          
UPDATE emp_test SET sal = sal+200 
WHERE ename IN ( SELECT ename
                 FROM emp a, (SELECT deptno, avg(sal) avg_sal
                              FROM emp
                              GROUP BY deptno)b
                 WHERE  a.deptno = b.deptno 
                 AND    a.sal < b.avg_sal
                );
---------------
UPDATE emp_test SET sal = sal+200 
WHERE sal < (SELECT ROUND(AVG(sal),2)
             FROM emp_test
             WHERE deptno = emp_test.deptno
             );
             
SELECT ename, a.deptno, a.sal, b.avg_sal
FROM emp_test a , (SELECT ROUND(AVG(sal),2) avg_sal
                    FROM emp_test
                    WHERE deptno = emp_test.deptno
                   )b;
SELECT *
FROM emp_test
WHERE sal < (SELECT ROUND(AVG(sal),2)b
             FROM emp_test
             WHERE deptno = emp_test.deptno
             ) ;


             
SELECT ROUND(AVG(sal),2)
        FROM emp_test
        WHERE deptno = emp_test.deptno
             group by deptno;             
             
             
             
             
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno ) b
ON (a.deptno = b.deptno) 
WHEN MATCHED THEN
    UPDATE SET sal = sal+200
    WHERE a.sal < avg_sal;


MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno) b
ON (a.deptno = b.deptno) 
WHEN MATCHED THEN
    UPDATE SET sal = CASE
                        WHEN a.sal< b.avg_sal THEN sal+200
                        ELSE sal
                     END;