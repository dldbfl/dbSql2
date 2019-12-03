
SELECT c.순위 ,c.sido, c.sigungu, d.부자동네, 도시발전지수
FROM
(SELECT ROWNUM 순위, sido, sigungu, 도시발전지수
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
AND a.sigungu (+) = b.sigungu))c, 

(SELECT ROWNUM 순위, sido,sigungu,  부자동네
 FROM(SELECT sido, SIGUNGU, Round(SAL/ PEOPLE,1) 부자동네
      FROM TAX))d

WHERE c.순위 = d.순위;