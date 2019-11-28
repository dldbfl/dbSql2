
--CON1
--CASE
--WHEN condition THEN return1
--END
--DECODE(col|expr, search1, return1, search2, return2....default)
SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN',sal*1.05,
                    'MANAGER',sal*1.10,
                    'PRESIDENT',sal*1.20,
                               sal ) bonus
FROM emp;               




SELECT empno, ename, CASE WHEN deptno = 10 THEN 'ACCOUNTING'
                          WHEN deptno = 20 THEN 'RESEARCH'
                          WHEN deptno = 30 THEN 'SALE'
                          WHEN deptno = 40 THEN 'OPERATION'
                          ELSE 'DDIT'
                    END DNAME
FROM emp;                    

SELECT empno, ename, DECODE(deptno, '10', 'ACCOUNTING',
                                    '20', 'RESEARCH',
                                    '30', 'SALES',
                                    '40', 'OPERATION',
                                    'DDIT') DNAME
FROM emp;                                    






SELECT empno, ename, TO_CHAR(hiredate,'RR/MM/DD') hiredate,
                                                    DECODE(MOD(TO_CHAR(hiredate, 'YY'),2),MOD(TO_CHAR(SYSdate, 'YY'), 2),'�ǰ����� ������','�ǰ����� �����') CONTACT_TO_DOCTOR      
FROM emp;






SELECT empno, ename, TO_CHAR(hiredate,'RR/MM/DD') hiredate,
                                                   CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)=0 THEN '�ǰ����� ������'
                                                        ELSE '�ǰ����� �����' 
                                                        END CONTACT_TO_DOCTOR                                                       
FROM emp;


SELECT empno, ename,
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
                 
            THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
        END contact_to_doctor
FROM emp;           





SELECT MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)


FROM EMP;

--CON1
--CASE
-- WHEN condition THEN return1
--END
--DECODE(col|expr, search1, return1, search2, return2....default)




--2.�ǰ����� ����ڸ� ��ȸ�ϴ� ������


SELECT empno, ename,
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
                 
            THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
        END contact_to_doctor
FROM emp;           


--2. ���⵵ �ǰ����� ����ڸ� ��ȸ�ϴ� ����
--2020�⵵

SELECT empno, ename,
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE,'yyyy')+1 ,  2)
                 THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
        END contact_to_doctor
FROM emp;           


SELECT empno, ename,
        DECODE( MOD(TO_CHAR(hiredate, 'YYYY'), 2), MOD(TO_CHAR(SYSDATE, 'YYYY')+1`, 2),'�ǰ����� �����',
                '�ǰ����� ������')contact_to_doctor
FROM emp;


Desc emp;

--function cond3

SELECT userid, usernm, alias, reg_dt,
        DECODE( MOD(TO_CHAR(reg_dt, 'YYYY'),2), MOD(TO_CHAR(reg_dt, 'YYYY'),2), '�ǰ����� �����'
                ,'�ǰ����� ������')contacttodoctor
FROM users;                

SELECT userid, usernm, alias, TO_CHAR(reg_dt,'YY/MM/DD')REG_DT,
        CASE WHEN MOD(TO_CHAR(reg_dt, 'YYYY'),2) = MOD( TO_CHAR(reg_dt, 'YYYY'),2) THEN '�ǰ����� �����'
             WHEN MOD(TO_CHAR(reg_dt, 'YYYY'),2) IS NULL THEN '�ǰ����� ������'
             ELSE '�ǰ����� ������'
        END contacttodoctor
FROM users;         


SELECT a.userid, a.usernm, a.alias,
        DECODE( mod(a.yyyy,2), mod(a.this_yyyy,2),'�ǰ��������','�ǰ���������') decode

FROM (SELECT userid, usernm, alias, TO_CHAR(reg_dt,'yyyy')yyyy,
            TO_CHAR(SYSDATE, 'YYYY') this_yyyy
            FROM users)a;
            
            
--GROUP FUNCTION
--Ư�� �÷��̳�, ǥ���� �������� �������� ���� ������ ����� ����
--COUNT-�Ǽ�, SUM-�հ�, AVG- ���, MAX-�ִ밪, MIN-�ּҰ�
--��ü ������ ������� (14���� ->1��)

SELECT MAX(SAL) m_sal, --���� ���� �޿�
       MIN(SAL) min_sal, --���� ���� �޿�
       ROUND(AVG(SAL),2) avg_sal, -- ������ �޿����
       SUM(SAL) sum_sal , -- �������� �޿� �հ�
       COUNT(sal) COUNT_sAL,     -- �޿� �Ǽ�(NULL�� �ƴ� ���̸� 1��)
       COUNT(MGR) COUNT_sAL,     -- �޿� �Ǽ�(NULL�� �ƴ� ���̸� 1��)
       COUNT(*) count_row--Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰������
       
FROM EMP;


------------------------------------------------------------------------------------------
SELECT *
FROM emp;

-- �μ���ȣ �� �׷��Լ� ����
SELECT deptno
    , MAX(sal) max_sal -- �μ����� ���� ���� �޿�
    , MIN(sal) min_sal -- �μ����� ���� ���� �޿�
    , ROUND(AVG(sal), 2) avg_sal  -- �μ����� �� ������ �޿� ���
    , SUM(sal) sum_sal -- �μ����� �� ������ �޿� �հ�
    , COUNT(sal) count_sal -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
    , COUNT(mgr) count_mgr -- �μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
    , COUNT(*) count_row -- �μ��� �������� (Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������)
FROM emp
GROUP BY deptno;

SELECT deptno, ename
    , MAX(sal) max_sal -- �μ����� ���� ���� �޿�
    , MIN(sal) min_sal -- �μ����� ���� ���� �޿�
    , ROUND(AVG(sal), 2) avg_sal  -- �μ����� �� ������ �޿� ���
    , SUM(sal) sum_sal -- �μ����� �� ������ �޿� �հ�
    , COUNT(sal) count_sal -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
    , COUNT(mgr) count_mgr -- �μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
    , COUNT(*) count_row -- �μ��� �������� (Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������)
FROM emp
GROUP BY deptno, ename;


--SELECT ������ GROUP BY ���� ǥ���� �÷� �̿��� �÷��� �� �� ����.
--�������� ������ ���� ����(�������� ���� ������ �Ѱ��� �����ͷ� �׷���)
--�� ���������� ��������� SELECT ���� ǥ���� ����
SELECT deptno, 'te', 1
    , MAX(sal) max_sal -- �μ����� ���� ���� �޿�
    , MIN(sal) min_sal -- �μ����� ���� ���� �޿�
    , ROUND(AVG(sal), 2) avg_sal  -- �μ����� �� ������ �޿� ���
    , SUM(sal) sum_sal -- �μ����� �� ������ �޿� �հ�
    , COUNT(sal) count_sal -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
    , COUNT(mgr) count_mgr -- �μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
    , COUNT(*) count_row -- �μ��� �������� (Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������)
FROM emp
GROUP BY deptno;





-------------------�� �������-------------------------------------------------

--�׷��Լ����� null�÷��� ��꿡�� ���ܵȴ�.
--emp ���̺��� comm�÷��� null�� �ƴ� �����ʹ� 4���� ����, 9���� null

SELECT count(comm) count_comm, --null�� �ƴ� ���� ���� 4
       sum(comm) sum_comm,  --null ���� ����, 300+500+1400+0= 2200
       sum(sal) sum_sal,
       sum(sal+ comm) tot_sal_sum,
       sum(sal+NVL(comm,0)) tot_sal_sum --null���� �����Ѵ�
       
FROM emp;

--WHERE ������ GROUP �Լ��� ǥ���� �� ����
--1.�μ��� �ִ� �޿� ���ϱ�
--2,�μ��� �ʴ�׺����� 3000�� �Ѵ� �ุ ���ϱ�
--deptno, �ִ�޿�

SELECT deptno, MAX(sal) �ִ�޿�
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000; --group�Լ��� ����Ҷ��� where���� having���� �ڿ��ٰ� �־���Ѵ�.

--function grp1

SELECT MAX(sal) max_sal,
       MIN(sal) min_sal,
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(sal) count_sal,
       COUNT(mgr) count_sal,
       COUNT(sal+NVL(sal,0)) count_all
FROM emp;       

--grp2
SELECT deptno,
       MAX(sal) max_sal,
       MIN(sal) min_sal,
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(sal) count_sal,
       COUNT(mgr) count_sal,
       COUNT(sal+NVL(sal,0)) count_all
FROM emp
GROUP BY deptno;

--grp3
SELECT deptno ename,
       MAX(sal) max_sal,
       MIN(sal) min_sal,
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(sal) count_sal,
       COUNT(mgr) count_sal,
       COUNT(sal+NVL(sal,0)) count_all
FROM emp
GROUP BY deptno
ORDER BY deptno;

--grp4
SELECT TO_CHAR(hiredate,'yyyymm'), COUNT(*) cnt                                                                                                         
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyymm');


--grp5
SELECT TO_CHAR(hiredate,'yyyy') Hire_yyyy , count(*) cot
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyy');

--grp6
select count(*) cnt, COUNT(DNAME), COUNT(loc)
FROM dept;
--��ü������ ���ϱ� (emp)
SELECT COUNT(*)
FROM emp;

--grp7 �μ��� ������ ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--emp���̺� ���

SELECT deptno
FROM emp
GROUP BY deptno;

SELECT COUNT(*)
FROM   (SELECT count(*)
        FROM emp
        GROUP BY deptno);

---DISTINCT �ߺ��� ���� �����Ѵ�.
SELECT COUNT(DISTINCT deptno)
FROM emp;



--JOIN
--1. ���̺� �������� ( �÷� �߰� ) 
--2. �߰��� �÷��� ���� update
--dname �÷��� em���̺� �߰�
DESC dept;
DESC emp;

--�÷� �߰� (dname, VARCHER2(14))
ALTER TABLE emp ADD (dname varchar2(14));

UPDATE emp SET dname = CASE 
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                      END
where dname is null;     
commit;



-- SALES --> MARKET SALES
-- �� 6���� ������ ������ �ʿ��ϴ�
-- ���� �ߺ��� �ִ� ���� (��������)
UPDATE emp SET dnanme = 'MARKET SALES'
WHERE dname = 'SALES';


--emp ���̺�, dept ���̺� ����
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;