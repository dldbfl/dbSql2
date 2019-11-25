--row_1 : emp 테이블에서 정렬없이 ROWNUM이 1~10인 행만 조회

SELECT ROWNUM empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


SELECT ROWNUM, a.* 
FROM
(SELECT ROWNUM rn, empno, ename  
FROM emp)a
WHERE rn BETWEEN 11 AND 14;


--row_3
SELECT b.*
FROM(SELECT ROWNUM rn, a.*
    FROM(SELECT ROWNUM empno, ename
                FROM emp
                ORDER By ename)a) b
WHERE rn BETWEEN 11 AND 14;

SELECT b.*
FROM(SELECT ROWNUM rn, a.*
        FROM (SELECT empno, ename
                FROM emp
                ORDER BY ename)a )b
WHERE rn IN (11,14);      
-------fuck you.


--DUAL 테이블 : sys 계정에 있는 누구나 사용가능한 테이블이며, 
--데이터는 한행만 존재하며 컬럼(dummy)도 하나 존재한다.

SELECT *
FROM dual;

--SUNGLE ROW FUNCTION : 행당 한번의 FUNCTION이 실행
-- 1개의 행 INPUT -> 1개의 행으로 OUTPUT (COLUMN)
-- 'Hello, World'

SELECT LOWER ('Hello, World'),UPPER('Hello, World'),INITCAP('Hello, World')
FROM emp;

SELECT empno, LOWER (ename) low_enm    
FROM emp
WHERE ename = UPPER('smith');

--테이블 컬럼을 가공해도 동일한 결과를 얻을수 있지만,
--테이블 컬럼보다는 상수쪽을 가공하는 것이 속도면에서 유리
--해당 컬럼에 인덱스가 존재하더라도 함수를 적용하게 되면 값이 달라지게 되어
--인덱스를 활용할 수 없게 된다.
--예외 : FBI(Function Based Index)

SELECT empno, LOWER (ename) low_enm    
FROM emp
WHERE LOWER(ename) = 'smith';

SELECT UPPER ('smith')
FROM dual;

--HELLO
--,
--WORLD
--HELLO, WORLD (위 3가지 문자열 상수를 이용, CONCAT 함수를 사용하여 문자열 결합)

SELECT CONCAT(CONCAT('HELLO', ', '),'WORLD') c1,
        'HELLO'||', '||'WORLD' c2,
        --시작인덱스는 1부터 , 종료인덱스 문자열까지 포함한다. (자바는 0부터 종료 인덱스전까지다. 언어마다 다르니 참고할것
        SUBSTR('HELLO, WORLD', 1, 8)i1, --SUBSTR 문자열, 시작인덱스, 종료인덱스
        
        --INSTR :문자열에 특정 문자열이 존재하는지, 존재할 경우 문자의 인덱스를 리턴
        INSTR('HELLO, WORLD', 'O')i2,  --5, 9
        --'HELLO, WORLD'문자열의 6번째 인덱스 이후에 등장하는 'O'문자열의 인덱스 리턴
        INSTR('HELLO, WORLD', 'O', 6)i3,-- 문자열의 특정 인덱스 이후부터 검색하도록 옵션
        
        --L>RPAD 특정문자열의 왼쪽/오른쪽에 설정한 문자열 길이보다 부족한 만큼 채워 넣는다.
        LPAD('HELLO, WORLD',15,'*') L1,
        LPAD('HELLO, WORLD',15) L2, --delfault 채움 문자는 공백이다.
        RPAD('HELLO, WORLD',15,'*') R1,
        
        --REPLACE( 대상문자열, 검색 문자열, 변경할 문자열)
        --대상문자열에서 검색 문자열을 변경할 문자열로 치환
        REPLACE('HELLO, WORLD','HELLO','hello') repl, --hello, WORLD
        
        --문자열 앞, 뒤의 공백을 제거
        '   HELLO, WORLD    'before_trim,
        TRIM('   HELLO, WORLD    ') after_trim,
        TRIM('H' FROM 'HELLO, WORLD    ') after_trim2
        
        --요것들은 행기준. 갯수가 그거다
               
FROM dept; 


--숫자 조작함수
--ROUND : 반올림 - ROUND(숫자, 반올림 자리)
--TRUNC : 절삭 - TRUNC(숫자, 절삭)
--MOD : 나머지 연산 MOD (피제제수, 제수) //MOD(5, 2) : 1

SELECT -- 반올림 결과가 소수점 한자리까지 나오도록( 소수점 둘째자리에서 반올림)
        ROUND(105.54, 1) r1,
        ROUND(105.55, 1) r2,
        ROUND(105.55, 0) r3, -- 소수점 첫번째 자리에서 반올림
        ROUND(105.54, -1) r4 -- 일의자리에서 반올림
        
        
FROM dual;

SELECT -- 절삭 결과가 소수점 한자리까지 나오도록( 소수점 둘째자리에서 절삭)
        TRUNC(105.54, 1) t1,
        TRUNC(105.55, 1) t2,
        TRUNC(105.55, 0) t3, -- 소수점 첫번째 자리에서 절삭
        TRUNC(105.54, -1) t4 -- 일의자리에서 절삭
        
        
FROM dual;

--MOD (피제수, 제수) 피제수를 제수로 나눈 나머지의 값
--MDO (5, 2) 의 결과 값은 : 1개

SELECT MOD (5, 2) M1
FROM dual;

--emp 테이블의 sal 컬럼을 1000으로 나눴을때 사원별 나머지 값을 조회하는 sql 작성
--ename, sal. sal/1000을 때의 몫, sal/1000을 때의 나머지

SELECT ename, sal, TRUNC(sal/1000) 몫, MOD (sal, 1000) s1,
        TRUNC(sal/1000)+ MOD (sal, 1000) sal2
FROM emp;


--DATE: 년월일, 시간, 분, 초
SELECT ename, hiredate, TO_CHAR(hiredate, 'YYYY_MM_DD hh24!mi!ss') --yyyy/mm/dd

FROM emp;

--SYSDATE : 서버의 현재 DATE를 리턴하는 내장함수, 특별한 인자가 없다. 
--DATE 연산 DATE + 정수N = DATE에 N일자 만큼 더한다.
--DATE 연산에 있어서 정수는 일자
--하루는 24시간
--DATE 타입에 시간을 더할 수도 있다. 1시간 = 1/24
SELECT TO_CHAR(SYSDATE + 5, 'YYYY-MM-DD hh24:mi:ss')AFTER5_DAYS,
       TO_CHAR(SYSDATE + 5/24, 'YYYY-MM-DD hh24:mi:ss')AFTER5_HOUR,
       TO_CHAR(SYSDATE + 5/24/60, 'YYYY-MM-DD hh24:mi:ss')AFTER5_min

FROM dual;

--Function (date 실습 fn1)

SELECT TO_DATE('2019-12-31','yy_mm_dd') lastday1,
       TO_CHAR(TO_DATE('20191231'),'YY/MM/DD') LASTDAY,
       TO_DATE('20191231', 'YY/MM/DD')-5 LASTDAT_BEFORE5,
       SYSDATE NOW,
       SYSDATE-5 NOW_BEFORE3
       
FROM dual
;

--YYYY, MM, DD, D(요일을 숫자로 : 일요일=1, 월요일=2, 화요일=3......토요일 =7
--IW(주차), HH, MI, SS

SELECT TO_CHAR(SYSDATE, 'YYYY') YYYY --현재년도
        ,TO_CHAR(SYSDATE, 'MM') MM --현재월
       ,TO_CHAR(SYSDATE, 'DD') DD --현재일
       ,TO_CHAR(SYSDATE, 'D') DAY --현재요일(주간일자 1-7)
       ,TO_CHAR(SYSDATE, 'IW') IW --현재일자의 주차
        , TO_CHAR(  TO_DATE('20191231','YYYYMMDD')  ,   'IW') IW2 --현재년도
       

FROM dual;    
       
           
           
--function 2 fn2
SELECT
TO_CHAR(SYSDATE,'yyyy-mm-dd') DT_DASH,
TO_CHAR(SYSDATE, 'YYYY-mm-dd hh24:mi:ss') DT_DASH_WITH_TIME,
TO_CHAR(SYSDATE, 'dd-mm-yyyy') DT_DD_MM_YYYY

FROM dual;


--DATE 타입의 ROUND, TRUNC 적용
SELECT TO_CHAR (SYSDATE, 'YYYy-mm-dd hh24:mi:ss') now,
    TO_CHAR (ROUND(SYSDATE,'YYYY'), 'YYYy-mm-dd hh24:mi:ss') now2,  --11->1
    TO_CHAR (ROUND(SYSDATE,'MM'), 'YYYy-mm-dd hh24:mi:ss') now3,    --25->1
    TO_CHAR (ROUND(SYSDATE,'dd'), 'YYYy-mm-dd hh24:mi:ss') now4
FROM dual;    
--DATE 타입의  TRUNC 적용
SELECT TO_CHAR (SYSDATE, 'YYYy-mm-dd hh24:mi:ss') now,
    TO_CHAR (TRUNC(SYSDATE,'YYYY'), 'YYYy-mm-dd hh24:mi:ss') now2,  --11->1
    TO_CHAR (TRUNC(SYSDATE,'MM'), 'YYYy-mm-dd hh24:mi:ss') now3,    --25->1
    TO_CHAR (TRUNC(SYSDATE,'dd'), 'YYYy-mm-dd hh24:mi:ss') now4
FROM dual;    

--날짜 조작 함수
--MONTHS_BETWEEN (date1, date2) : date2와 date1 사이의 개월수 
--ADD_MONTHS(date, 가감할 개월수) : date에서 특정 개월 수를 더하거나 뺸 날짜
--NEXT_DAY(date, weekday(1~7)): date 이후 첫 weekday 날짜
--LAST_DAY(date) : date가 속한 월의 마지막 날짜


--MONTHS_BETWEEN (date1, date2)
SELECT MONTHS_BETWEEN(TO_DATE('2019-11-25', 'YYYY-MM-dd'),
                       TO_DATE('2019-03-31','yyyy-mm-dd')) m_bet,
        TO_DATE('2019-11-25', 'yyyy-mm-dd') -
        TO_DATE('2019-03-31', 'yyyy-mm-dd') d_m -- 두 날짜 사이의 일자수
FROM dual;

--ADD_MONTHS ( date, number(+,-) )
SELECT ADD_MONTHS( TO_DATE('20191125','YYYYMMDD'), 5) NOW_AFTER5M,
        ADD_MONTHS( TO_DATE('20191125','YYYYMMDD'), -5) NOW_BEFORE5M
        ,SYSDATE + 100 --100일뒤의 날짜        
FROM dual;        

--NEXT_DAY (date, weekday number(1~7))
SELECT NEXT_DAY(SYSDATE, 7) -- 오늘 날짜 (2019/11/25)일 이후 등장하는 첫번째 토요일
FROM dual;
