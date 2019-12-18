--WITH
--WITH ����̸� AS (
-- ��������
--)
-- SELECT *
-- FROM ����̸�

-- WITH1
-- deptno, avg(sal) avg_sal
-- �ش� �μ��� �޿������ ��ü ������ �޿� ��պ��� ���� �μ� ��ȸ
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
group by deptno     
HAVING avg(sal) > (SELECT avg(sal) FROM emp)
;

--WITH ���� ����Ͽ� ���� ������ �ۼ�
WITH dept_sal_avg AS(
    SELECT deptno, ROUND(AVG(sal),2) avg_sal
    FROM emp
    group by deptno),
    emp_sal_avg AS(
        SELECT AVG(sal) avg_sal FROM emp
    )    
SELECT *
FROM dept_sal_avg
WHERE avg_sal > (SELECT avg_sal FROM emp_sal_avg);

WITH test AS(
    SELECT 1, 'TEST' FROM DUAL UNION ALL
    SELECT 2, 'TEST2' FROM DUAL UNION ALL
    SELECT 3, 'TEST3' FROM DUAL )
SELECT *
FROM test;

--��������
--�޷¸����
--CONNECT BY LEVEL <= N
--���̺��� ROW �Ǽ��� N��ŭ �ݺ��Ѵ�
--CONNECT BY LEVEL ���� ����� ���������� 
--SELECT ������ LEVEL �̶�� Ʈ�� �÷��� ����� �� �ִ�.
--������ ǥ���ϴ� Ư�� �÷����� 1���� �����ϸ� ROWNUM�� �����ϳ�
--���� ���Ե� START WITH , CONNECT BY ������ �ٸ� ���� ���� �ȴ�.

--2019�� 11���� 30�ϱ��� ����
--201911
--���� + ���� = ������ŭ �̷��� ����
-- 2019 --> �ش����� ��¥�� ���ϱ��� �����ϴ°�??
--1-��, 2-��, ....7-��
--/*�Ͽ����̸� ��¥*/,/*�������̸� ��¥*/..../*������̸� ��¥*/
SELECT  /*d, dt,*/ 
        IW,
        MAX(DECODE(d, 1, dt)) sUn, MAX(DECODE(d, 2, dt))mon, MAX(DECODE(d, 3, dt))tue,
        MAX(DECODE(d, 4, dt)) wen, MAX(DECODE(d, 5, dt))thu, MAX(DECODE(d, 6, dt))fri,
        MAX(DECODE(d, 7, dt))sat
FROM
    (SELECT TO_DATE(:yyyymm,'YYYYMM')+(LEVEL -1) dt,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL),'IW') IW

     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD'))
        
GROUP BY IW
ORDER BY sat;    

-----

SELECT  /*d, dt,*/ 
        
        MAX(DECODE(d, 1, dt)) sUn, MAX(DECODE(d, 2, dt))mon, MAX(DECODE(d, 3, dt))tue,
        MAX(DECODE(d, 4, dt)) wen, MAX(DECODE(d, 5, dt))thu, MAX(DECODE(d, 6, dt))fri,
        MAX(DECODE(d, 7, dt))sat
FROM
    (SELECT TO_DATE(:yyyymm,'YYYYMM')+(LEVEL -1) dt,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL),'IW') IW

     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD'))
        
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);    


SELECT TO_CHAR(last_day(TO_DATE(:yyyymm, 'YYYYMM')),'dd') day
FROM dual;

SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= TO_CHAR(last_day(TO_DATE(:yyyymm, 'YYYYMM')),'dd');



--���� calendar2 �ش���� ��� ������ ���� ��¥�� ���� ����ϵ��� ������ �ۼ��غ�����.
SELECT  /*d, dt,*/ 
        dt-(d-1),
        MAX(DECODE(d, 1, dt)) sUn, MAX(DECODE(d, 2, dt))mon, MAX(DECODE(d, 3, dt))tue,
        MAX(DECODE(d, 4, dt)) wen, MAX(DECODE(d, 5, dt))thu, MAX(DECODE(d, 6, dt))fri,
        MAX(DECODE(d, 7, dt))sat
FROM
    (SELECT TO_DATE(:yyyymm,'YYYYMM')+(LEVEL-1) dt,
            dt-d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL),'IW') IW

     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD'))
        
GROUP BY dt-(d-1)
ORDER BY sat; 

---

create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT *
FROM SALES;

--1~6���� ���� �����͸� ������ ���� ���ϼ���.
SELECT DECODE(dt,  dt)jun
FROM sales;
          
SELECT TO_CHAR(dt,'MM')
FROM sales;

SELECT NVL(MIN(DECODE(mm,'01',sales_sum)),0)jan, NVL(MIN(DECODE(mm,'02',sales_sum)),0)FEB, NVL(MIN(DECODE(mm,'03',sales_sum)),0)MAR,
       NVL(MIN(DECODE(mm,'04',sales_sum)),0)AFR, NVL(MIN(DECODE(mm,'05',sales_sum)),0)MAY, NVL(MIN(DECODE(mm,'06',sales_sum)),0)jun
FROM (SELECT TO_CHAR(dt, 'MM')mm, SUM(sales) sales_sum
      FROM sales
      GROUP BY TO_CHAR(dt, 'MM'));


create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XXȸ��', '');
insert into dept_h values ('dept0_00', '�����κ�', 'dept0');
insert into dept_h values ('dept0_01', '������ȹ��', 'dept0');
insert into dept_h values ('dept0_02', '�����ý��ۺ�', 'dept0');
insert into dept_h values ('dept0_00_0', '��������', 'dept0_00');
insert into dept_h values ('dept0_01_0', '��ȹ��', 'dept0_01');
insert into dept_h values ('dept0_02_0', '����1��', 'dept0_02');
insert into dept_h values ('dept0_02_1', '����2��', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '��ȹ��Ʈ', 'dept0_01_0');
commit;

--�� ���߾ȴ�..

SELECT * 
FROM dept_h
START WITH deptcd='dept0' --�������� deptcd = 'dept0' -->xȸ�� �ֻ���� ����
CONNECT BY PRIOR deptcd = p_deptcd
;
/*
    dept0(XXȸ��)
        dept0_00(�����κ�)
            dept0_00_0������ ��.)
        dept0_01(������ȹ��)
            dept0_01_0(��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02(�����ý��ۺ�)
            dept0_02_0(����1��)
            dept0_01_0(����2��) ��ȸ
            
*/           
--���� calendar2 �ش���� ��� ������ ���� ��¥�� ���� ����ϵ��� ������ �ۼ��غ�����.


SELECT  MAX(NVL(DECODE(d, 1, dt),dt-d+1)) sUn, MAX(NVL(DECODE(d, 2, dt),dt-d+2))mon, MAX(NVL(DECODE(d, 3, dt),dt-d+3))tue,
        MAX(NVL(DECODE(d, 4, dt),dt-d+4)) wen, MAX(NVL(DECODE(d, 5, dt),dt-d+5))thu, MAX(NVL(DECODE(d, 6, dt),dt-d+6))fri,
        MAX(NVL(DECODE(d, 7, dt),dt-d+7))sat
FROM
    (SELECT ROWNUM rn,
            TO_DATE(:yyyymm,'YYYYMM')+(LEVEL-1)dt ,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL),'IW') IW
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD'))
        
GROUP BY dt-d-1
ORDER BY sat;  

---

SELECT LDT-FDT+1
FROM
(SELECT TO_DATE(:yyyymm,'YYYYMM') dt,
       LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM'))+7- TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'D') ldt,
       TO_DATE(:yyyymm,'YYYYMM')-(TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'),'D')-1) fdt
 FROM dual);
 
SELECT  MAX(DECODE(d, 1, dt)) sUn, MAX(DECODE(d, 2, dt))mon, MAX(DECODE(d, 3, dt))tue,
        MAX(DECODE(d, 4, dt)) wen, MAX(DECODE(d, 5, dt))thu, MAX(DECODE(d, 6, dt))fri,
        MAX(DECODE(d, 7, dt))sat
FROM
    (SELECT ROWNUM rn,
--            TO_DATE(:yyyymm,'YYYYMM')+(LEVEL-1)dt , -- before
            TO_DATE(:yyyymm,'YYYYMM')-(TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'),'D')-1)+(LEVEL-1) dt,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')-(TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'),'D')-1)+(LEVEL-1),'D') d,
            TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+(LEVEL),'IW') IW
     FROM dual
     CONNECT BY LEVEL <= (SELECT LDT-FDT+1
FROM
(SELECT TO_DATE(:yyyymm,'YYYYMM') dt,
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM'))+7- TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'D') ldt,
        TO_DATE(:yyyymm,'YYYYMM')-(TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'),'D')-1) fdt
        FROM dual)))        
GROUP BY dt-d-1
ORDER BY sat;  
 
 