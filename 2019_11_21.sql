--col IN (valuel, value2...)
--col의 값이 IN 연산자 안에 나열된 값 중에 포함될 떄 참으로 판정

--RDBMS - 집합개념
--1.집합에는 순서가 없다.
--{1,5,7}, {5,1,7}

--2.집합에는 중복이 없다.
--{1,1,5,7}, {5,1,7}
SELECT *
FROM emp
WHERE deptno IN (10, 20); --emp ㅔ이블의 직원의 소속 부서가 10번이거나 20번인 직원정보만 조회

--이거나  --> or(또는)
--이고    --> AND(그리고)

-- IN --> OR
-- BETWEEN AND --> AND + 산술비교

SELECT *
FROM emp
WHERE deptno = 10 or deptno = 20;


--where 3

SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid IN ('brown', 'cony', 'sally');


DESC users;
SELECT *
FROM users;

--LIKE 연산자 : 문자열 매칭 연산
-- % : 여러 문자 (문자가 없을 수도 있다.)
-- _ : 하나의 문자

--emp테이블에서 사원 이름(ename)이 s로 시작하는 사원 정보만 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--SMITH 
--SCOTT
--첫글자는 s로 시작하고 4번째 글자는 T
--두번째, 세번째, 다섯번째 문자는 어떤 문자든 올 수 있다.

SELECT *
FROM emp
WHERE ename LIKE 'S__T_';

SELECT *
FROM emp
WHERE ename LIKE '___T_';

--where 4
--member 테이블에서 회원의 성이 [신]씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오.
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';
--member 테이블에서 회원의 이름에 [이]씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오.
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

--컬럼 값이 NULL인 데이터 찾기
--emp 테이블에 보면 MGR 컬럼이 NULL 데이터가 존재

SELECT *
FROM emp
WHERE MGR IS NULL;  -- NULL 값 확인에는 IS NULL 연산자를 사용
WHERE MGR = 7698;   -- MGR 컬럼 값이 7698인 사원 정보조회
WHERE MGR = NULL;   -- MGR 컬럼 값이 NULL인 사원 정보조회

--where 6
--emp 테이블에서 상여(comm)가 있는 회원의 정보를 다음과 같이 조회되도록 쿼리를 작성하시오

update emp 
SET comm = 0
WHERE empno = 7844;
commit;

SELECT *
FROM emp
WHERE comm IS NOT NULL;

--AND : 조건을 동시에 만족
--OR : 조건을 한개만 충족하면 만족
SELECT *
FROM emp
WHERE mgr=7698
AND sal > 1000;

--emp 테이블에서 mgr가 7698 이거나 (or) , 급여가 1000보다 큰 사람
SELECT * 
FROM emp
WHERE mgr=7698
OR sal > 1000;

--emp테이블에서 관리자 사번이 7698, 7839가 아닌 직원 정보 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839) OR mgr IS NULL ; --NULL 값이 포함되어있으면 IS NOT NULL을 썼어야해

--WHERE 7
-- emp 테이블에서 job이 SLAESMAN이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요.
SELECT *
FROM emp
WHERE job IN 'SALESMAN' AND HIREDATE > to_date('19810601','yyyymmdd');      