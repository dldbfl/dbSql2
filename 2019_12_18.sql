
SELECT dept_h.*, LEVEL, LPAD(' ',(LEVEL-1)*3)||deptnm
FROM dept_h
START WITH deptcd='dept0' --시작점은 deptcd = 'dept0' -->x회사 최상위 조직
CONNECT BY PRIOR deptcd = p_deptcd
;

SELECT LPAD('XX회사',15,'*')
FROM dual;

SELECT dept_h.*, LEVEL, LPAD(' ',(LEVEL-1)*3)||DEPTNM
FROM dept_h
START WITH deptcd='dept0_02' --시작점은 deptcd = 'dept0' -->x회사 최상위 조직
CONNECT BY PRIOR deptcd = p_deptcd
;

SELECT *
FROM dept_h;

--디자인팀(dept0_00_0)을 기준으로 상향식 계층쿼리 작성
--자기 부서의 부모 부서와 연결을 한다.
--prior는 내가 지금 읽은 행, 안 붙은건 지금 읽을 행
--행에 붙는 접두사다. 
SELECT dept_h.*, LEVEL,LPAD(' ',(LEVEL-1)*3)||DEPTNM
FROM dept_h
START WITH deptcd ='dept0_00_0'
-- CONNECT BY PRIOR p_deptcd = deptcd
CONNECT BY deptcd = PRIOR p_deptcd;  --이런식으로써도됨


SELECT deptcd,LPAD(' ',(LEVEL-1)*3)||DEPTNM deptnm, p_deptcd
FROM dept_h
START WITH deptcd ='dept0_00_0'
-- CONNECT BY PRIOR p_deptcd = deptcd
CONNECT BY deptcd = PRIOR p_deptcd;  --이런식으로써도됨

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

create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all
select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;


SELECT LPAD(' ',(LEVEL-1)*3)||s_id ps_id, value
FROM h_sum
START WITH s_id ='0'
-- CONNECT BY PRIOR p_deptcd = deptcd
CONNECT BY PRIOR s_id = ps_id;  --이런식으로써도됨

create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);

insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;

--실습 h_5
SELECT LPAD(' ',(LEVEL-1)*3)||ORG_CD,NO_EMP
FROM NO_EMP
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR ORG_CD = PARENT_ORG_CD;

--pruning branch(가지치기)
--계층 쿼리의 실행 순서
--FROM --> START WITH - CONNECT BY --> WHERE
--조건을 CONNECT BY 절에 기술한 경우
-- . 조건에 따라 다음 ROW로 연결이 안되고 종료
--조건을 WHERE절에 기술한 경우
--. START WITH - CONNECT BY절에 의해 계층으로 나온 결과에 
--WHERE 절에 기술한 결과 값에 해당하는 데이터만 조회

--최상위 노드에서 하향식으로 탐색
--connect by 절에 deptnm != '정보기획부' 조건을 기술한 경우
SELECT *
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm !='정보기획부';

--WHERE 절에 deptnm != '정보기획부' 조건을 기술한 경우
--계층 쿼리를 실행하고 나서 최종결과에 WHERE절조건을 적용
SELECT *
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

-- 계층 쿼리에서 사용 가능한 특수 함수
-- CONNECT_BY_ROOT(col) 가장 최상위 row의 col 정보 값 조회
-- SYS_CONNECT_BY_PATH(col, 구분자) : 최상위 row에서 현재 로우까지 col 값을
-- 구분자로 연결해준 문자열(EX : XX회사 - 디자인부디자인팀)
-- CONNECT_BY_ISLEAF : 해당 ROW가 마지막 노드인지 (LEAF NODE)
-- leaf node : 1, node: 0

SELECT deptcd,LPAD(' ',4*(LEVEL-1)) ||deptnm, 
       CONNECT_BY_ROOT(deptnm) croot,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm,'----'),'-') sys_path, --L트림쓰면 왼쪽부터 지정문자열삭제가능
       CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

