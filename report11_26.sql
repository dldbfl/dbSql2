SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN',sal*1.05,
                    'MANAGER',sal*1.10,
                    'PRESIDENT',sal*1.20,
                               sal ) bonus
FROM emp;               

SELECT empno, ename, DECODE(deptno, '10', 'ACCOUNTING',
                                    '20', 'RESEARCH',
                                    '30', 'SALES',
                                    '40', 'OPERATION',
                                    'DDIT') DNAME
FROM emp;                                    



----------�ȵ˴ϴ�. DECODE���� ���� �����ʴ°Ű��ƿ�,.-----------
SELECT empno, ename, TO_CHAR(hiredate,'RR/MM/DD') hiredate,
                                                    DECODE(hiredate, MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)=0 ,'�ǰ����� ������',
                                                                    '�ǰ����� �����') CONTACT_TO_DOCTOR                                                       
FROM emp;

----------�ȵ˴ϴ�. DECODE���� ���� �����ʴ°Ű��ƿ�,--------------
SELECT empno, ename, TO_CHAR(hiredate,'RR/MM/DD') hiredate,
                                                   CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)=0 THEN '�ǰ����� ������'
                                                        ELSE '�ǰ����� �����' 
                                                        END CONTACT_TO_DOCTOR                                                       
FROM emp;






SELECT MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)


FROM EMP;
