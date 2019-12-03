 
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

--도시발전지수
SELECT *
FROM FASTFOOD
WHERE sido = '대전광역시';
GROUP BY GB;


--1번 도시발전지수 점수 표시 및, 발전지수 순으로 나열
--도시발전지수  =(버거킹개수+Kfc개수+맥도날드 개수)/ 롯데ㄹ아 개수
--순위 / 시도/ 시군구/ 도시발전지수(소수점 첫째짜리까지)
--1 /서울특별시  /서초구    /7.5

SELECT sigungu
FROM FASTFOOD
WHERE GB IN ('롯데리아');


SELECT L.sido, L.sigungu , NVL2(COUNT(L.GB),COUNT(L.GB),1) ,COUNT(L.GB)
FROM FASTFOOD L--, FASTFOOD AL
WHERE L.GB IN ('롯데리아')
--AND L.GB(+) = AL.GB
GROUP BY  L.sido, L.sigungu;


SELECT MKB.sido, MKB.sigungu, ROUND((COUNT(MKB.GB)/a.롯데리아지수),1) 도시발전지수, COUNT(MKB.GB),COUNT(a.GB)
FROM FASTFOOD MKB,(SELECT L.GB, L.sido, L.sigungu , NVL2(COUNT(L.GB),COUNT(L.GB),1)롯데리아지수
                  FROM FASTFOOD L
                  WHERE L.GB IN ('롯데리아')
                  GROUP BY L.GB, L.sido, L.sigungu) a
WHERE MKB.GB IN ('버거킹','맥도날드','KFC')
AND MKB.GB = a.GB (+)
GROUP BY 롯데리아지수, MKB.sido, MKB.sigungu, a.GB
ORDER BY 도시발전지수 desc;



SELECT ROWNUM 순위.
FROM (SELECT MKB.sido, MKB.sigungu, ROUND((COUNT(MKB.GB)/a.롯데리아지수),1) 도시발전지수 
      FROM FASTFOOD MKB,(SELECT L.GB, L.sido, L.sigungu , COUNT(L.GB) 롯데리아지수
      FROM FASTFOOD L
      WHERE L.GB IN ('롯데리아')
      GROUP BY L.GB, L.sido, L.sigungu) a
      WHERE MKB.GB IN ('버거킹','맥도날드','KFC')
      GROUP BY 롯데리아지수, MKB.sido, MKB.sigungu) b;


---------------다시하기 위껀
SELECT ROWNUM 순위, sido, sigungu, 도시발전지수
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
AND a.sigungu (+) = b.sigungu);

(SELECT ROWNUM d.순위, d.sido,nsigungu,  부자동네
FROM(SELECT sido, SIGUNGU, Round(SAL/ PEOPLE,1) 부자동네
     FROM TAX)n)d

WHERE c.순위 = d.순위;