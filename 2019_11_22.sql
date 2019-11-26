--where8 (emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.(IN, NOT IN)

SELECT
    *
FROM emp 
WHERE DEPTNO NOT LIKE '10' AND HIREDATE > TO_DATE('19810601','yyyymmdd');

SELECT
    *
FROM emp
WHERE DEPTNO != 10 --<>, !=
AND HIREDATE > to_date('19810601','yyyymmdd'); --sql������ ����ϰ� �Ѵ�. �������� �ϸ� �Ʒ����� �����. (!!LIKE �������� ������ ���;� �˸´�!!)

--WHERE9 emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���. (NOT IN ���)

SELECT
    *
FROM emp
WHERE DEPTNO NOT IN '10'
AND HIREDATE > to_date('19810601','yyyymmdd');

--WHERE 10 emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���.
--(�μ��� 10, 20 ,30�� �ִٰ� �����ϰ� IN �����ڸ� ���

SELECT
    *
FROM emp
WHERE DEPTNO IN (20,30)
AND HIREDATE > TO_DATE('19810601','yyyymmdd');

--WHERE 11 emp ���̺��� job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���.

SELECT
    *
FROM emp
WHERE JOB LIKE 'S%' 
OR HIREDATE > TO_DATE('19810601','yyyymmdd');

--WHERE 12 emp ���̺��� JOb�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ������ ���� ��ȣ���ϼ���
SELECT
    *
FROM emp
WHERE JOB = 'SALESMAN'
OR EMPNO LIKE '78%';

--WHERE 13 emp ���̺��� job�� salesman �̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ���������� ��ȸ�Ͻÿ�(LIKE ��� ��)
DESC emp; -- ���� number(a) = a������ ���ڰ� �����ִ�.
SELECT
    *
FROM emp
WHERE JOB = 'SALESMAN'
OR empno BETWEEN 7800 AND 7899;

SELECT
    *
FROM emp
WHERE JOB = 'SALESMAN'
OR empno >7800 
AND empno < 7899;


--������ �켱���� (AND > OR)
--����� �̸��� smith �̰ų�, �����̸��� allen�̸鼭 ������ salesman�� ����

SELECT
    *
FROM emp
WHERE ename = 'SMITH'
OR ename = 'ALLEN'
AND job = 'SALESMAN';

SELECT
    *
FROM emp
WHERE ename = 'SMITH'
OR (ename = 'ALLEN' AND job = 'SALESMAN');


--�����̸��� smith �̰ų� aleen�̸鼭 ������ salesman�λ��
SELECT
    *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

--where 14 emp ���̺��� job�� salesman�̰ų� �����ȣ�� 78�� �����ϸ鼭 �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ�ϼ���
SELECT
    *
FROM emp
WHERE job = 'SALESMAN' OR empno like '78%' AND HIREDATE > to_date('19810601','yyyymmdd');

--����������
--�������� : ASC (ǥ���������) �⺻��
--�������� : DESC (�����Ұ�

/*
    SELECT coll, col2, ....
    FROM ���̺��
    WHERE col1 = '��'
    ORDER BY ���ı����÷�1 [ASC /DESC] , ���ı����÷�2....[ASC /DESC]
    */
    
--��� (emp) ���̺��� ������ ������ ���� �̸����� ��������

SELECT
    *
FROM emp
ORDER BY ENAME ASC; -- �����ص� �����ϴ�.
    
    
--��� (emp) ���̺��� ������ ������ ���� �̸����� ��������

SELECT
    *
FROM emp
ORDER BY ENAME DESC; -- �����ϸ� ���������ǹ�����.

--��� (emp) ���̺��� ������ ������ �μ���ȣ�� �������� �����ϰ� �μ���ȣ�� �������� sal ������������ ����
--�޿�(sal)�� �������Ѵ� �̸����� �������� �����Ѵ�.
SELECT
    *
FROM emp
ORDER BY DEPTNO, SAL DESc, ename;


--���� �÷��� ALIAS�� ǥ��
SELECT
    deptno, sal, ename nm
FROM emp
ORDER BY nm;

--��ȸ�ϴ� �÷��� ��ġ �ε����� ǥ�� ����

SELECT
    deptno, sal, ename nm
FROM emp
ORDER BY 3; --��õ������ �ʴ¹��̴�. �÷��� �߰��ɰ�� ���� ����ɼ����ֱ⶧���̿�!

--oder by �ǽ� 1 
SELECT
    *
FROM dept
ORDER BY dname;

SELECT
    *
FROM dept
ORDER BY loc desc;

--order by 2
--emp���̺��� ��comm�������ִ»���鸸 ��ȸ�ϰ� �󿩸� ���� �޴»���� ������ȸ�������ϰ� �翩��
--�󿩰����� ��������
SELECT
    *
FROM emp
WHERE COMM IS NOT NULL
AND COMM !=0
ORDER BY COMM DESC, EMPNO ASC;

--order by3
--emp ���̺��� �����ڰ� �ִ� ����鸸 ��ȸ�ϰ� ���� ������ �������� �����ϰ� ������ ���� ��� ����� ū ��� �� ���� ��ȸ���� ������ �ۼ��ϼ���.

SELECT
    *
FROM emp
WHERE MGR IS NOT NULL
ORDER BY JOB , EMPNO DESC;

--oderby4

SELECT
    *
FROM emp 
WHERE DEPTNO in ('10','30') AND SAL > 1500
ORDER BY ENAME DESC;

--ROWNUM 
SELECT ROWNUM, empno, ename
FROM emp;


SELECT
    *
FROM emp 
WHERE DEPTNO in ('10','30') AND SAL > 1500
ORDER BY ENAME DESC;


SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 2;       --ROUNUM = equal �񱳴� 1�� ����



SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM <= 2;       --<= (<) ROWNUM�� 1���� ���������� ��ȸ�ϴ� ���� ����

SELECT
    *
FROM emp 
WHERE DEPTNO in ('10','30') AND SAL > 1500
ORDER BY ENAME DESC;
       --1���� �����ϴ� ��� ����


--SELECT ���� ORDER BY ������ �������
--SELECT ->ROWNUM->ORDER BY


SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

--INLINE VIEW�� ���� ���� ���� �����ϰ�, �ش����� ROWBNUM�� ����
--��SELECT ���� * ����ϰ�, �ٸ� Į��|ǥ������ ���� ���
--*�տ� ���̺� ���̳� ���̺� ��Ī�� ���� 

SELECT empno, ename
      FROM emp
      ORDER BY ename;

SELECT ROWNUM, a.*
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename) a;
      
      
 --ROWNUM �ǽ�1
--emp ���̺��� ROWNUM ���� 1~10�� ���� ��ȸ�ϴ� ������ �ۼ��غ�����
SELECT ROWNUM rn, empno , ename
FROM emp
where ROWNUM <= 10;
      
   --ROWNUM �ǽ� 2
   --ROWNUM ���� 11~20 (11~14)�� ���� ��ȸ�ϴ� ������ �ۼ������.

SELECT ROWNUM rn, empno, ename
      FROM emp
      WHERE ROWNUM BETWEEN 11 AND 14; -- ����� ��Ʈ���ϸ� ���ؿ�  

SELECT ROWNUM RN, empno, ename
      FROM emp;   
   
   
SELECT a.*
FROM (SELECT ROWNUM RN, empno, ename
      FROM emp)a
WHERE RN >= 11 AND RN <= 20;

SELECT a.*
FROM (SELECT ROWNUM rn , empno, ename
      FROM emp) a
WHERE rn BETWEEN 11 AND 20;

--row_3
--emp �����̺��� ename���� ������ ����� 11��° ��� 14��° �ุ ��ȸ�ϴ� ������ �ۼ��غ�����

SELECT empno, ename
                FROM emp
                ORDER BY ename;

SELECT b.*
FROM(SELECT ROWNUM rn, a.*
        FROM (SELECT empno, ename
                FROM emp
                ORDER BY ename)a )b
WHERE rn IN (11,14);      


SEL LOWER('MR. SCOTT MCMILLAN') "Lowercase"
  FROM DUAL