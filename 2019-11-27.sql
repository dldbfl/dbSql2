
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
                                                    DECODE(MOD(TO_CHAR(hiredate, 'YY'),2),MOD(TO_CHAR(SYSdate, 'YY'), 2),'건강검진 비대상자','건강검진 대상자') CONTACT_TO_DOCTOR      
FROM emp;






SELECT empno, ename, TO_CHAR(hiredate,'RR/MM/DD') hiredate,
                                                   CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)=0 THEN '건강검진 비대상자'
                                                        ELSE '건강검진 대상자' 
                                                        END CONTACT_TO_DOCTOR                                                       
FROM emp;


SELECT empno, ename,
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
                 
            THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
        END contact_to_doctor
FROM emp;           





SELECT MOD(TO_NUMBER(TO_CHAR(hiredate,'yy')),2)


FROM EMP;

--CON1
--CASE
-- WHEN condition THEN return1
--END
--DECODE(col|expr, search1, return1, search2, return2....default)




--2.건강검진 대상자를 조회하는 쿼리ㅏ


SELECT empno, ename,
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
                 
            THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
        END contact_to_doctor
FROM emp;           


--2. 내년도 건강검진 대상자를 조회하는 쿼리
--2020년도

SELECT empno, ename,
        CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) =
                 MOD(TO_CHAR(SYSDATE,'yyyy')+1 ,  2)
                 THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
        END contact_to_doctor
FROM emp;           


SELECT empno, ename,
        DECODE( MOD(TO_CHAR(hiredate, 'YYYY'), 2), MOD(TO_CHAR(SYSDATE, 'YYYY')+1`, 2),'건강검진 대상자',
                '건강검진 비대상자')contact_to_doctor
FROM emp;


Desc emp;

--function cond3

SELECT userid, usernm, alias, reg_dt,
        DECODE( MOD(TO_CHAR(reg_dt, 'YYYY'),2), MOD(TO_CHAR(reg_dt, 'YYYY'),2), '건강검진 대상자'
                ,'건강검진 비대상자')contacttodoctor
FROM users;                

SELECT userid, usernm, alias, TO_CHAR(reg_dt,'YY/MM/DD')REG_DT,
        CASE WHEN MOD(TO_CHAR(reg_dt, 'YYYY'),2) = MOD( TO_CHAR(reg_dt, 'YYYY'),2) THEN '건강검진 대상자'
             WHEN MOD(TO_CHAR(reg_dt, 'YYYY'),2) IS NULL THEN '건강검진 비대상자'
             ELSE '건강검진 비대상자'
        END contacttodoctor
FROM users;         


SELECT a.userid, a.usernm, a.alias,
        DECODE( mod(a.yyyy,2), mod(a.this_yyyy,2),'건강검진대상','건강검진비대상') decode

FROM (SELECT userid, usernm, alias, TO_CHAR(reg_dt,'yyyy')yyyy,
            TO_CHAR(SYSDATE, 'YYYY') this_yyyy
            FROM users)a;
            
            
--GROUP FUNCTION
--특정 컬럼이나, 표현을 기준으로 여러행의 값을 한행의 결과로 생성
--COUNT-건수, SUM-합계, AVG- 평균, MAX-최대값, MIN-최소값
--전체 직원을 대상으로 (14건을 ->1건)

SELECT MAX(SAL) m_sal, --가장 높은 급여
       MIN(SAL) min_sal, --가장 낮은 급여
       ROUND(AVG(SAL),2) avg_sal, -- 전직원 급여평균
       SUM(SAL) sum_sal , -- 전직원의 급여 합계
       COUNT(sal) COUNT_sAL,     -- 급여 건수(NULL이 아닌 값이면 1건)
       COUNT(MGR) COUNT_sAL,     -- 급여 건수(NULL이 아닌 값이면 1건)
       COUNT(*) count_row--특정 컬럼의 건수가 아니라 행의 개수를 알고싶을때
       
FROM EMP;


------------------------------------------------------------------------------------------
SELECT *
FROM emp;

-- 부서번호 별 그룹함수 적용
SELECT deptno
    , MAX(sal) max_sal -- 부서에서 가장 높은 급여
    , MIN(sal) min_sal -- 부서에서 가장 낮은 급여
    , ROUND(AVG(sal), 2) avg_sal  -- 부서에서 전 직원의 급여 평균
    , SUM(sal) sum_sal -- 부서에서 전 직원의 급여 합계
    , COUNT(sal) count_sal -- 부서의 급여 건수(null이 아닌 값이면 1건)
    , COUNT(mgr) count_mgr -- 부서 직원의 관리자 건수(KING의 경우 MGR가 없다)
    , COUNT(*) count_row -- 부서의 조직원수 (특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을때)
FROM emp
GROUP BY deptno;

SELECT deptno, ename
    , MAX(sal) max_sal -- 부서에서 가장 높은 급여
    , MIN(sal) min_sal -- 부서에서 가장 낮은 급여
    , ROUND(AVG(sal), 2) avg_sal  -- 부서에서 전 직원의 급여 평균
    , SUM(sal) sum_sal -- 부서에서 전 직원의 급여 합계
    , COUNT(sal) count_sal -- 부서의 급여 건수(null이 아닌 값이면 1건)
    , COUNT(mgr) count_mgr -- 부서 직원의 관리자 건수(KING의 경우 MGR가 없다)
    , COUNT(*) count_row -- 부서의 조직원수 (특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을때)
FROM emp
GROUP BY deptno, ename;


--SELECT 절에는 GROUP BY 절에 표현된 컬럼 이외의 컬럼이 올 수 없다.
--논리적으로 성립이 되지 않음(여러명의 직원 정보로 한건의 데이터로 그루핑)
--단 예외적으로 상수값들은 SELECT 절에 표현이 가능
SELECT deptno, 'te', 1
    , MAX(sal) max_sal -- 부서에서 가장 높은 급여
    , MIN(sal) min_sal -- 부서에서 가장 낮은 급여
    , ROUND(AVG(sal), 2) avg_sal  -- 부서에서 전 직원의 급여 평균
    , SUM(sal) sum_sal -- 부서에서 전 직원의 급여 합계
    , COUNT(sal) count_sal -- 부서의 급여 건수(null이 아닌 값이면 1건)
    , COUNT(mgr) count_mgr -- 부서 직원의 관리자 건수(KING의 경우 MGR가 없다)
    , COUNT(*) count_row -- 부서의 조직원수 (특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을때)
FROM emp
GROUP BY deptno;





-------------------위 수정요망-------------------------------------------------

--그룹함수에서 null컬럼은 계산에서 제외된다.
--emp 테이블에서 comm컬럼이 null이 아닌 데이터는 4건이 존재, 9건은 null

SELECT count(comm) count_comm, --null이 아닌 값으 개수 4
       sum(comm) sum_comm,  --null 값을 제외, 300+500+1400+0= 2200
       sum(sal) sum_sal,
       sum(sal+ comm) tot_sal_sum,
       sum(sal+NVL(comm,0)) tot_sal_sum --null값을 포함한다
       
FROM emp;

--WHERE 절에는 GROUP 함수를 표현할 수 없다
--1.부서별 최대 급여 구하기
--2,부서별 초대그병값이 3000이 넘는 행만 구하기
--deptno, 최대급여

SELECT deptno, MAX(sal) 최대급여
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000; --group함수를 사용할때는 where말고 having절을 뒤에다가 넣어야한다.

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
--전체직원수 구하기 (emp)
SELECT COUNT(*)
FROM emp;

--grp7 부서의 개수를 조회하는 쿼리를 작성하시오
--emp테이블 사용

SELECT deptno
FROM emp
GROUP BY deptno;

SELECT COUNT(*)
FROM   (SELECT count(*)
        FROM emp
        GROUP BY deptno);

---DISTINCT 중복된 곳을 제거한다.
SELECT COUNT(DISTINCT deptno)
FROM emp;



--JOIN
--1. 테이블 구조변경 ( 컬럼 추가 ) 
--2. 추가된 컬럼에 값을 update
--dname 컬럼을 em테이블에 추가
DESC dept;
DESC emp;

--컬럼 추가 (dname, VARCHER2(14))
ALTER TABLE emp ADD (dname varchar2(14));

UPDATE emp SET dname = CASE 
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                      END
where dname is null;     
commit;



-- SALES --> MARKET SALES
-- 총 6건의 데이터 변경이 필요하다
-- 값의 중복이 있는 형태 (반정규형)
UPDATE emp SET dnanme = 'MARKET SALES'
WHERE dname = 'SALES';


--emp 테이블, dept 테이블 조인
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;