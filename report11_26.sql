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



----------안됩니다. DECODE에는 식이 들어가지않는거같아요,.-----------
SELECT empno, ename, TO_CHAR(hiredate,'RR/MM/DD') hiredate,
                                                    DECODE(hiredate, MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)=0 ,'건강검진 비대상자',
                                                                    '건강검진 대상자') CONTACT_TO_DOCTOR                                                       
FROM emp;

----------안됩니다. DECODE에는 식이 들어가지않는거같아요,--------------
SELECT empno, ename, TO_CHAR(hiredate,'RR/MM/DD') hiredate,
                                                   CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)=0 THEN '건강검진 비대상자'
                                                        ELSE '건강검진 대상자' 
                                                        END CONTACT_TO_DOCTOR                                                       
FROM emp;






SELECT MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)


FROM EMP;
