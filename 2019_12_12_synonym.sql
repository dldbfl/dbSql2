SELECT *
FROM PC03.users;

SELECT *
FROM jobs;

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES
WHERE OWNER = 'PC03';


SELECT *
FROM PC03.FASTFOOD;
-- PC03.fastfood --> fastfood 시노님으로 생성
-- 생성 후 다음 sql이 정상적으로 작동하는지 확인

CREATE SYNONYM fastfood FOR PC03.fastfood;

SELECT
    *
FROM fastfood;