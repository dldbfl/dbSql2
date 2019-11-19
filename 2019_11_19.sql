--DML : SELECT
/*
    select *
    from 테이블명;
*/

--코드의 이해를 돕기 위해 설명을 작성 : 주석

-- prod 테이블의 모든 컬럼을 대상으로 모든 데이터를 조회
select * from prod;

--prod 테이블의 prod_id, prod_name 컬럼만 모든 데이터에 대해 조회
select prod_id, prod_name from prod;

--현재 접속한 계정에 생성되어 있는 테이블 목록을 조회
select * from USER_TABLES;

--테이블의 컬럼 리스트 조회

select * from USER_TAB_COLUMNS;

--DESC 테이블명
DESC PROD;

-- SELECT 실습 1 
SELECT * FROM lprod;

-- SELECT 실습 2

SELECT buyer_id, buyer_name
FROM buyer;

--3 

SELECT
    *
FROM cart;

--4

SELECT mem_id, mem_pass, mem_name

FROM member;