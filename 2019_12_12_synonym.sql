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
-- PC03.fastfood --> fastfood �ó������ ����
-- ���� �� ���� sql�� ���������� �۵��ϴ��� Ȯ��

CREATE SYNONYM fastfood FOR PC03.fastfood;

SELECT
    *
FROM fastfood;