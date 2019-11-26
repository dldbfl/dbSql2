--��¥���� �Լ�
--ROUND, TRUNC
--(MONTHS_BETWEEN) ADD_MONTHS, NEXT_DAY
--LAST_DAY : �ش� ��¥�� ���� ���� ������ ����(DATE)


--�� : 1,3, 5, 7, 8, 10, 12 : 31��
-- : 2 -���� ���� 28, 29
-- : 4, 6, 9, 11 : 30��
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

--fn3
--�ش� ��¥�� ������ ��¥�� �̵�
--���� �ʵ常 �����ϱ�
--DATE --> �����÷�(DD)�� ����
--DATE --> ���ڿ�(DD)
--TO_CHAR(DATE, '����')
--DATE : LAST_DAY(TO_DATE('201912','YYYYMM'))
--���� : 'DD'
SELECT :yyyymm param, TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')), 'DD') dt
FROM dual;



--SYSDATE�� YYYY/MM/DD ������ ���ڿ��� ����
--'2019/11/26' ���ڿ� -->DATE
SELECT TO_DATE(TO_CHAR(SYSDATE,'YYYY/MM/DD'),'YYYY/MM/DD'),
--YYYY-MM-DD HH24:MI:ss ���ڿ��� ����
TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYY/MM/DD'),'YYYY/MM/DD'),'YYYY-MM-DD HH24:MI:ss')
FROM dual;


--EMPNO    NOT NULL NUMBER(4)
--HIREDATE          DATE  
DESC emp;

--empno�� 7369�� ���� ���� ��ȸ �ϱ�

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';


SELECT *
FROM TABLE(dbms_xplan.display);



EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';


SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69'; -- 69 -> ���ڷ� ����


SELECT *
FROM TABLE(dbms_xplan.display);


--
SELECT*
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

--DATEŸ���� ������ ����ȯ�� ����� ������ ����
-- YY -->
-- RR --> 
SELECT*
FROM emp
WHERE hiredate >= TO_DATE('81/06/01', 'RR/MM/DD');    
--WHERE hiredate >= '81/06/01';    


SELECT TO_DATE('50/05/05', 'RR/MM/DD'),
       TO_DATE('49/05/05', 'RR/MM/DD'),
       TO_DATE('50/05/05', 'YY/MM/DD'),
       TO_DATE('49/05/05', 'YY/MM/DD')
FROM dual;


--���� --> ���ڿ�
--���ڿ� --> ����
--���� : 1000000 --> 1,000,000 (�ѱ�)
--���� : 1000000 --> 1.000.000,00 (����)
--��¥ ���� : YYYY, MM, DD, HH24, MI, SS
--���� ���� : ���� ǥ�� : 9, �ڸ������� ���� 0ǥ�� : 0, ȭ����� : L
--          1000�ڸ� ���� : , �Ҽ��� : .
--���� ->���ڿ� TO_CHAR(����, '����')
--���� ������ �������� ���� �ڸ����� ����� ǥ��
SELECT empno, ename, sal, TO_CHAR(sal, 'L009,999') fm_sal
FROM emp;

SELECT TO_CHAR(100000000000, '999,999,999,999,999')
FROM dual;

--NULL ó�� �Լ� : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2) : �Լ� ���� �ΰ�
--expr1�� NULL�̸� expr2�� ��ȯ
--expr1�� NULL�� �ƴϸ� expr1�� ��ȯ

SELECT empno, ename, comm, NVL(comm, -1) nvl_comm
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL expr2����
--expr1 IS NULL expr3����
SELECT empno, ename, comm, NVL2(comm, 1000, -500) nv2_comm,
                    NVL2(comm, comm, -500) nvl_comm --NVL�� ������ ���
FROM emp;

--NULLIF(expr1, expr2)
--expr1 = expr2 NULL�� ����
--expr1 != expr2 expr1�� ����
--comm�� NULL�϶� comm+500 : NULL
--   NULLIF(NULL, NULL) : NULL
--comm�� NULL�� �ƴҶ� comm+500 : comm+500
--   NULLIF(comm, comm+500) : comm
SELECT empno, ename, comm, NULLIF(comm, comm+500) nullif_comm
FROM emp;


--COALESCE(expr1, expr2, expr3.....)
--�����߿� ù��°�� �����ϴ� NULL�� �ƴ� exprN�� ����
-- expr1 IS NOT NULL epxr1�� �����ϰ�
-- expr1 IS NULL COALESCE(expr2, expr3.....)
SELECT empno, ename, comm, sal, COALESCE(comm,sal) coal
FROM emp;

--Function (null �ǽ� fn4)

SELECT empno, ename, mgr, nvl(mgr,9999) mgr_N, nvl2(mgr,mgr,9999) mgr_N_2, COALESCE(mgr,null,mgr,mgr,null,9999) mgr_N_3
FROM emp;

--Fuction null �ǽ� fn5

SELECT userid, usernm, REG_DT, nvl(reg_dt,(TO_CHAR(sysdate,'yy/mm/dd'))) N_REG_DT
FROM users
WHERE userid NOT IN 'brown';
--���߾� �� �Ҽ��ֽ�


--condition
--case
--emp.job �÷��� �������� 
--'SALESMAN'�̸� sal*1.05�� ������ �� ����
--'MANAGER'�̸� sal*1.10�� ������ �� ����
--'PRESIDENT'�̸� sal*1.20�� ������ �� ����
-- �� ������ ������ �ƴҰ�� sal ����
-- empno, ename, sal, ���� ������ �޿�

SELECT empno, ename, job, sal,
        CASE
            when job = 'SALESMAN' THEN sal * 1.05
            when job = 'MANAGER' THEN sal * 1.10
            when job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
        END bonus,
        comm,
        
        --NULLó�� �Լ� ������� �ʰ� CASE���� �̿��Ͽ�
        --comm�� NULL�� ��� -10�� �����ϵ��� ����
        CASE
        
            WHEN comm IS NULL THEN -10
            ELSE comm
        END               
FROM emp;

--DECODE
SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN',sal*1.05,
                    'MANAGER',sal*1.10,
                    'PRESIDENT',sal*1.20,
                               sal ) bonus
FROM emp;               






