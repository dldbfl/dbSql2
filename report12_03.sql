
SELECT c.���� ,c.sido, c.sigungu, d.���ڵ���, ���ù�������
FROM
(SELECT ROWNUM ����, sido, sigungu, ���ù�������
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
AND a.sigungu (+) = b.sigungu))c, 

(SELECT ROWNUM ����, sido,sigungu,  ���ڵ���
 FROM(SELECT sido, SIGUNGU, Round(SAL/ PEOPLE,1) ���ڵ���
      FROM TAX))d

WHERE c.���� = d.����;