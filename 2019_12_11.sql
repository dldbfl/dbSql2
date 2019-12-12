--INDEX�� ��ȸ�Ͽ� ������� �䱸���׿� �����ϴ� �����͸� �����
--�� �� �ִ� ���

SELECT * 
FROM emp;

SELECT * 
FROM emp
ORDER BY empno;

--emp ���̺��� ��� �÷��� ��ȸ
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

--emp ���̺��� empno �÷��� ��ȸ
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

--���� �ε��� ���� 
--pk_emp �������� ���� --> unique ���� ���� --> pk_emp �ε��� ����

--INDEX ����( �÷� �ߺ� ����)
--UNIQUE INDEX : �ε��� �÷��� ���� �ߺ��� �� ���� �ε���
--               (emp.empno, dept.deptno)
--NON-UNIQUE INDEX(default) : �ε��� �÷��� ���� �ߺ��� �� �ִ� �ε��� (emp.job)

ALTER TABLE emp DROP CONSTRAINT pk_emp;

--CREATE UNIQUE INDEX idx_n_emp_01 ON emp (empno);

--���� ��Ȳ�̶� �޶��� ���� empno �÷����� ������ �ε�����
--UNIQUE -> NON -UNIQUE �ε����� �����
--�̷��� �Ǹ� �ߺ��Ǵ� ���� �� ���� �� ������ ����ϴ� ���ߴ°� �ƴ϶� ������ ��� ����Ϸ�����.
--�ߺ��Ȱ� ������ ��+1���� �˻��ؼ� �ߺ��Ȱ� ���°� Ȯ���ϰ� ������ ����ٳ� 

CREATE INDEX idx_n_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE empno =7782;

SELECT *
FROM TABLE (dbms_xplan.display);

--7782
DELETE emp WHERE ename = 'brown';
INSERT INTO emp emp (empno, ename) VALUES (7782,'brown');
commit;

--emp ���̺� job �÷����� non-unique �ε��� ����
--�ε����� idx_n_emp_02

CREATE INDEX idx_n_emp_02 ON emp(job);

SELECT job, rowid
FROM emp
ORDER BY job;

--emp ���̺��� �ε��� �� 2�� ����
--1. empno
--2. job

SELECT *
FROM emp
WHERE empno = 7369;

--IDX_02 dlseprtm
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job= 'MANAGER'
AND ename LIKE 'c%';

SELECT *
FROM TABLE (dbms_xplan.display);

--idx_n_emp_03
--emp ���̺��� job , ename �÷����� non-unique �ε��� ����
CREATE INDEX idx_n_emp_03 ON emp (job, ename);


--idx_n_emp_04
--emp ���̺��� ename, job�÷����� non-unique�ε��� ����
CREATE  INDEX idx_n_emp_04 ON emp (ename, job);

SELECT ename , job, rowid
FrOM emp
ORDER BY ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE 'J%' ;


SELECT *
FROM TABLE (dbms_xplan.display);


--join ���������� �ε���
--emp ���̺��� empnoĿ������ primary key ���������� ����
--dept���̺��� deptno�÷����� primary key ���������� ����
--emp ���̺��� primary key ������ ������ �����̹Ƿ� ����
DELETE emp
where ename = 'brown';
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

commit;


EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

sELECT *
FROM TABLE (dbms_xplan.display);


DROP TABLE dept_test;

CREATE TABLE dept_test AS 
    SELECT *
    FROM dept
    WHERE 1 = 1;
    
CREATE UNIQUE INDEX idx_n_dept_01 ON dept_test (deptno);
CREATE INDEX idx_n_dept_02 ON dept_test (dname);
CREATE INDEX idx_n_dept_03 ON dept_test (deptno,dname);


--idx2

DROP INDEX idx_n_dept_03;

