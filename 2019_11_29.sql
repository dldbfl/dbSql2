
--�ǽ� join 1
SELECT *
FROM prod;
SELECT *
FROM LPROD;

SELECT LPROD_GU, LPROD_NM, PROD_ID, PROD_NAME
FROM prod, lprod
WHERE PROD_LGU = LPROD_GU
ORDER BY prod_id;

--�ǽ� join2
SELECT *
FROM PROD;
SELECT *
FROM buyer;



SELECT buyer_id, buyer_name, prod_id ,prod_name
FROM buyer, prod
WHERE PROD_BUYER = BUYER_ID
ORDER BY prod_id;


--�ǽ� 3
SELECT    *
FROM cart;
SELECT    *
FROM prod;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM cart, member, prod
WHERE mem_id = cart_member AND prod_id = cart_prod
ORDER BY mem_id;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM cart JOIN member ON mem_id = cart_member JOIN prod ON prod_id = cart_prod; 

--�ǽ� 4
SELECT *
FROM customer;
SELECT * 
FROM cycle;


SELECT cycle.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid   
AND cnm IN ('brown','sally');

--�ǽ� 5
SELECT *
FROM product;

SELECT cycle.CID, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND product.pid = cycle.PID
AND cnm IN ('brown', 'sally');

--�ǽ� 6
SELECT cycle.CID, cnm, cycle.pid, pnm,SUM(cnt) CNT
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND product.pid = cycle.PID
GROUP BY  cycle.CID, cnm, cycle.pid, pnm
ORDER BY CNT;

--�ǽ� 7
select product.pid, pnm, sum(cnt) cnt
FROM product, cycle 
WHERE cycle.pid = product.PID 
GROUP BY product.pid, pnm; --cnt ���� ���ƾ� �ϳ��� ������ �ΰڽ��ϴ�.
