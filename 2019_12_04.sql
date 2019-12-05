-- 1. tax 테이블을 이용 시도/ 시군구별 인당 연말정산 신고행ㄱ구하기
--2. 신고액이 많은 순서로 랭킹부여하기
--랭킹 시도 시군구 연말정산신고액
SELECT ROWNUM 랭킹 , tax1.*
FROM
(SELECT sido,sigungu,sal,people,ROUND((SAL/PEOPLE),1) 연말정산신고액
 FROM tax
 ORDER BY 연말정산신고액 DESC) tax1;   

UPDATE tax SET PEOPLE = 70391
WHERE SIDO = '대전광역시'
AND SIGUNGU = '동구';
commit;

------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM
(SELECT ROWNUM 랭킹, sido, sigungu, 도시발전지수
FROM
(SELECT b.sido, b.sigungu, a.cnt, b.cnt , ROUND(NVL2(a.cnt,a.cnt,1)/b.cnt,1) as 도시발전지수
FROM
(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb IN ('KFC','버거킹','맥도날드')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb IN '롯데리아'
GROUP BY sido, sigungu
ORDER BY sido, sigungu) b

WHERE a.sido (+) = b.sido
AND a.sigungu (+) = b.sigungu
ORDER BY 도시발전지수 DESC)) c, 



(SELECT ROWNUM 랭킹, sido,sigungu,  연말정산신고액
 FROM(SELECT sido, SIGUNGU, Round(SAL/ PEOPLE,1) 연말정산신고액
      FROM TAX
      ORDER BY 연말정산신고액 DESC))d

WHERE c.랭킹 (+) = d.랭킹
ORDER BY d.랭킹

;

------------------------------------------------------------------------------------------



-- 1. tax 테이블을 이용 시도/ 시군구별 인당 연말정산 신고행ㄱ구하기
--2. 신고액이 많은 순서로 랭킹부여하기
--랭킹 시도 시군구 연말정산신고액
SELECT ROWNUM 랭킹 , tax1.*
FROM
(SELECT sido,sigungu,sal,people,ROUND((SAL/PEOPLE),1) 연말정산신고액
 FROM tax
 ORDER BY 연말정산신고액 DESC) tax1;   

UPDATE tax SET PEOPLE = 70391
WHERE SIDO = '대전광역시'
AND SIGUNGU = '동구';
commit;

------------------------------------------------------------------------------------------------------------------------
--도시발전지수 시도, 시군구와 연말정산 납입금액의 시도, 시군구가 
--같은지역끼리 조인
--정렬순서는 tax테이블의 id 컬럼 순으로 정렬
--1 서울특별시 강남구 도시발전지수
SELECT *
FROM tax;

update tax set sigungu = trim(sigungu);
commit;

SELECT id, c.sido, c.sigungu, 도시발전지수, d.sido, d.sigungu, 연말정산신고액
FROM
 (SELECT b.sido, b.sigungu, a.cnt, b.cnt , ROUND(NVL2(a.cnt,a.cnt,1)/b.cnt,1) as 도시발전지수
  FROM
  (SELECT sido, sigungu, COUNT(*) cnt
   FROM fastfood
   WHERE gb IN ('KFC','버거킹','맥도날드')
   GROUP BY sido, sigungu) a,

  (SELECT sido, sigungu, COUNT(*) cnt
   FROM fastfood
   WHERE gb IN '롯데리아'
   GROUP BY sido, sigungu) b

WHERE a.sido (+) = b.sido
AND a.sigungu (+) = b.sigungu
) c, 


(SELECT id, sido, SIGUNGU, Round(SAL/ PEOPLE,1) 연말정산신고액
      FROM TAX
      )d

WHERE c.sigungu (+)  = d.sigungu
ORDER By d.id

;

--서브쿼리 시작합니다요
    
--smith가 속한 부서 찾기 
SELECT deptno
FROM emp 
WHERE ename ='SMITH';

SELECT *
FROM emp 
WHERE deptno != (SELECT deptno
                FROM emp 
                WHERE ename ='SMITH');
                
                
--SCALAR SUBQUERY
--SELECT 절에 표현된 서브쿼리
--한 행 , 한 COLUMN을 조회해야 한다.
SELECT empno, ename, deptno,
        (SELECT dname FROM dept) dname
FROM emp;        
--INLINE VIEW
--FROM 절에 사용되는 서브쿼리

--SUBQUERY
--WHERE 절에 사용되는 서브쿼리


--서브쿼리 실습 sub1
SELECT COUNT(*) cnt
FROM emp
WHERE SAL >(SELECT AVG(sal)
            FROM emp);


--서브쿼리 실습 sub2
SELECT *
FROM emp
WHERE SAL >(SELECT AVG(sal)
            FROM emp);
            
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                   FROM emp
                   WHERE ename in('SMITH','WARD'));
                                
--SMITH 혹은 WARD보다 급여를 적게받는 직원조회
SELECT *
FROM emp
WHERE sal <ANY (SELECT sal
                FROM emp
                WHERE ename in('SMITH','WARD'));
                   
                   
                   
--관리자 역할을 하지않는 사원 정보 조회
--NOT IN 연산자 사용시오류
SELECT *
FROM emp -- 사원 정보 조회 --> 관리자 역할을 하지않는
WHERE empno NOT IN (SELECT NVL(mgr,-1)
                    FROM emp);
                         
                         
                         
SELECT *
FROM emp -- 사원 정보 조회 --> 관리자 역할을 하지않는
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT null);
                         


--pairwise(여러컬럼의 값을 동시에 만족해야하는 경우)
--ALLEN, CLEAK의 매니저와 부서번호가 동시에 같은 사원 정보 조회
--(7698,30)
--(7839,10)
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499,7782))
AND deptno IN (SELECT deptno
              FROM emp
              WHERE empno IN (7499,7782));
               
               
--비상호연관 서브쿼리
--메인쿼리의 컬럼을 서브쿼리에서 사용하지 않는  형태의 서브쿼리
--비상호 연관 서브쿼리의 경우 메인쿼리에서 사용하는 테이블 , 서브쿼리 조회 순서를 
--성능적으로 유리한 쪽으로 판단하여 순서를 결정한다.
--메인쿼리의 emp 테이블을 먼저읽을 수 있고, 서브쿼리의 emp 테이블을 
--먼저 읽을 수 있다.

--비상호 연관 서브쿼리에서 서브쿼리 쪽 테이블을 먼저 읽을 때는
--서브쿼리가 제공자 역할을 했다 라고 모 도서에서 표현
--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 나중에 읽을 때는
--서브쿼리가 확인자 역할을 했다 라고 모 도서에서 표현

--직원의 급여 평균 보다 높은 급여를 받는 직원 정보 조회
--직원의 급여평균

sELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
            
            
             
--상호연관 서브쿼리 
--해당직원이 속한 부서의 평균급여보다 높은 급여를 받는 직원 조회
SELECT *
FROM emp 
WHERE sal > (SELECT AVG(sal)
                FROM emp
                WHERE deptno = deptno);


--10번 부서의 급여 평균
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;