--DML : SELECT
/*
    select *
    from ���̺��;
*/

--�ڵ��� ���ظ� ���� ���� ������ �ۼ� : �ּ�

-- prod ���̺��� ��� �÷��� ������� ��� �����͸� ��ȸ
select * from prod;

--prod ���̺��� prod_id, prod_name �÷��� ��� �����Ϳ� ���� ��ȸ
select prod_id, prod_name from prod;

--���� ������ ������ �����Ǿ� �ִ� ���̺� ����� ��ȸ
select * from USER_TABLES;

--���̺��� �÷� ����Ʈ ��ȸ

select * from USER_TAB_COLUMNS;

--DESC ���̺��
DESC PROD;

-- SELECT �ǽ� 1 
SELECT * FROM lprod;

-- SELECT �ǽ� 2

SELECT buyer_id, buyer_name
FROM buyer;

--3 

SELECT
    *
FROM cart;

--4

SELECT mem_id, mem_pass, mem_name

FROM member;