 
--outerjoin2

SELECT NVL(TO_CHAR(buy_date,'YY/MM/DD'),TO_CHAR(to_date('20051025','yyyymmdd'),'YY/MM/DD')) buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod, prod
WHERE buy_prod (+)= prod_id
AND buy_date(+) = to_date('2005/01/25');

--outerjoin3

SELECT NVL(buy_date,TO_CHAR(TO_DATE('20050125'),'YY/MM/DD')) buy_date, buy_prod, prod_id, prod_name, 
        NVL(buy_qty,0) buy_qty 
FROM buyprod, prod
WHERE buy_prod (+)= prod_id
AND buy_date(+) = to_date('2005/01/25');

--outerjoin4
SELECT * FROM cycle;
SELECT * FROM product;

 
SELECT product.pid, product.pnm, nvl(CID,1)cid,nvl(DAY,0)day, nvl(CNT,0)cnt
FROM cycle, product
WHERE cycle.cid (+)= 1
AND cycle.pid(+) = product.pid;

--outerjoin 5
SELECT * FROM cycle;
SELECT * FROM product;
SELECT * FROM customer;

SELECT a.pid, a.pnm, a.cid,customer.cnm, a.day, a.cnt 
FROM
    (SELECT product.pid, product.pnm, 
            :cid cid,nvl(DAY,0)day, nvl(CNT,0)cnt
    FROM cycle, product
    WHERE cycle.cid (+)= :cid
    AND cycle.pid(+) = product.pid) a, customer
WHERE a.cid = customer.cid;    


--crossjoin
SELECT * FROM customer, product;

--���ù�������
SELECT *
FROM FASTFOOD
WHERE sido = '����������';
GROUP BY GB;


--1�� ���ù������� ���� ǥ�� ��, �������� ������ ����
--���ù�������  =(����ŷ����+Kfc����+�Ƶ����� ����)/ �Ե����� ����
--���� / �õ�/ �ñ���/ ���ù�������(�Ҽ��� ù°¥������)
--1 /����Ư����  /���ʱ�    /7.5

SELECT sigungu
FROM FASTFOOD
WHERE GB IN ('�Ե�����');


SELECT L.sido, L.sigungu , NVL2(COUNT(L.GB),COUNT(L.GB),1) ,COUNT(L.GB)
FROM FASTFOOD L--, FASTFOOD AL
WHERE L.GB IN ('�Ե�����')
--AND L.GB(+) = AL.GB
GROUP BY  L.sido, L.sigungu;


SELECT MKB.sido, MKB.sigungu, ROUND((COUNT(MKB.GB)/a.�Ե���������),1) ���ù�������, COUNT(MKB.GB),COUNT(a.GB)
FROM FASTFOOD MKB,(SELECT L.GB, L.sido, L.sigungu , NVL2(COUNT(L.GB),COUNT(L.GB),1)�Ե���������
                  FROM FASTFOOD L
                  WHERE L.GB IN ('�Ե�����')
                  GROUP BY L.GB, L.sido, L.sigungu) a
WHERE MKB.GB IN ('����ŷ','�Ƶ�����','KFC')
AND MKB.GB = a.GB (+)
GROUP BY �Ե���������, MKB.sido, MKB.sigungu, a.GB
ORDER BY ���ù������� desc;



SELECT ROWNUM ����.
FROM (SELECT MKB.sido, MKB.sigungu, ROUND((COUNT(MKB.GB)/a.�Ե���������),1) ���ù������� 
      FROM FASTFOOD MKB,(SELECT L.GB, L.sido, L.sigungu , COUNT(L.GB) �Ե���������
      FROM FASTFOOD L
      WHERE L.GB IN ('�Ե�����')
      GROUP BY L.GB, L.sido, L.sigungu) a
      WHERE MKB.GB IN ('����ŷ','�Ƶ�����','KFC')
      GROUP BY �Ե���������, MKB.sido, MKB.sigungu) b;


---------------�ٽ��ϱ� ����
SELECT ROWNUM ����, sido, sigungu, ���ù�������
FROM
(SELECT b.sido, b.sigungu, a.cnt, b.cnt , ROUND(NVL2(a.cnt,a.cnt,1)/b.cnt,1) as ���ù�������
FROM
(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb IN ('KFC','����ŷ','�Ƶ�����')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb IN '�Ե�����'
GROUP BY sido, sigungu
ORDER BY sido, sigungu) b

WHERE a.sido (+) = b.sido
AND a.sigungu (+) = b.sigungu);

(SELECT ROWNUM d.����, d.sido,nsigungu,  ���ڵ���
FROM(SELECT sido, SIGUNGU, Round(SAL/ PEOPLE,1) ���ڵ���
     FROM TAX)n)d

WHERE c.���� = d.����;