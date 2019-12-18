--WITH
--WITH 블록이름 AS (
-- 서브쿼리
--)
-- SELECT *
-- FROM 블록이름

-- WITH1
-- deptno, avg(sal) avg_sal
-- 해당 부서의 급여평균이 전체 직원의 급여 평균보다 높은 부서 조회
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
group by deptno     
HAVING avg(sal) > (SELECT avg(sal) FROM emp)
;

--WITH 절을 사용하여 위의 쿼리를 작성
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

--계층쿼리
--달력만들기
--CONNECT BY LEVEL <= N
--테이블의 ROW 건수를 N만큼 반복한다
--CONNECT BY LEVEL 절을 사용한 쿼리에서는 
--SELECT 절에서 LEVEL 이라는 트굿 컬럼을 사용할 수 있다.
--계층을 표현하는 특수 컬럼으로 1부터 증가하며 ROWNUM과 유사하나
--추후 배우게될 START WITH , CONNECT BY 절에서 다른 점을 배우게 된다.

--2019년 11월은 30일까지 존재
--201911
--일자 + 정수 = 정수만큼 미래의 일자
-- 2019 --> 해당년월의 날짜가 몇일까지 존재하는가??
--1-일, 2-월, ....7-토
--/*일요일이면 날짜*/,/*월요일이면 날짜*/..../*토요일이면 날짜*/
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



--복습 calendar2 해당월의 모든 주차에 대해 날짜를 같이 출력하도록 쿼리를 작성해보세요.
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

--1~6월의 실적 데이터를 다음과 같이 구하세요.
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

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;

--아 집중안대..

SELECT * 
FROM dept_h
START WITH deptcd='dept0' --시작점은 deptcd = 'dept0' -->x회사 최사우이 조직
CONNECT BY PRIOR deptcd = p_deptcd
;
/*
    dept0(XX회사)
        dept0_00(디자인부)
            dept0_00_0디자인 팀.)
        dept0_01(정보기획부)
            dept0_01_0(기획팀)
                dept0_00_0_0(기획파트)
        dept0_02(정보시스템부)
            dept0_02_0(개발1팀)
            dept0_01_0(개발2팀) 조회
            
*/           
--복습 calendar2 해당월의 모든 주차에 대해 날짜를 같이 출력하도록 쿼리를 작성해보세요.


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
 
 