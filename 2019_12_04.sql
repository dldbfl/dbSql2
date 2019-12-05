-- 1. tax ���̺��� �̿� �õ�/ �ñ����� �δ� �������� �Ű��ड���ϱ�
--2. �Ű���� ���� ������ ��ŷ�ο��ϱ�
--��ŷ �õ� �ñ��� ��������Ű��
SELECT ROWNUM ��ŷ , tax1.*
FROM
(SELECT sido,sigungu,sal,people,ROUND((SAL/PEOPLE),1) ��������Ű��
 FROM tax
 ORDER BY ��������Ű�� DESC) tax1;   

UPDATE tax SET PEOPLE = 70391
WHERE SIDO = '����������'
AND SIGUNGU = '����';
commit;

------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM
(SELECT ROWNUM ��ŷ, sido, sigungu, ���ù�������
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
AND a.sigungu (+) = b.sigungu
ORDER BY ���ù������� DESC)) c, 



(SELECT ROWNUM ��ŷ, sido,sigungu,  ��������Ű��
 FROM(SELECT sido, SIGUNGU, Round(SAL/ PEOPLE,1) ��������Ű��
      FROM TAX
      ORDER BY ��������Ű�� DESC))d

WHERE c.��ŷ (+) = d.��ŷ
ORDER BY d.��ŷ

;

------------------------------------------------------------------------------------------



-- 1. tax ���̺��� �̿� �õ�/ �ñ����� �δ� �������� �Ű��ड���ϱ�
--2. �Ű���� ���� ������ ��ŷ�ο��ϱ�
--��ŷ �õ� �ñ��� ��������Ű��
SELECT ROWNUM ��ŷ , tax1.*
FROM
(SELECT sido,sigungu,sal,people,ROUND((SAL/PEOPLE),1) ��������Ű��
 FROM tax
 ORDER BY ��������Ű�� DESC) tax1;   

UPDATE tax SET PEOPLE = 70391
WHERE SIDO = '����������'
AND SIGUNGU = '����';
commit;

------------------------------------------------------------------------------------------------------------------------
--���ù������� �õ�, �ñ����� �������� ���Աݾ��� �õ�, �ñ����� 
--������������ ����
--���ļ����� tax���̺��� id �÷� ������ ����
--1 ����Ư���� ������ ���ù�������
SELECT *
FROM tax;

update tax set sigungu = trim(sigungu);
commit;

SELECT id, c.sido, c.sigungu, ���ù�������, d.sido, d.sigungu, ��������Ű��
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
   GROUP BY sido, sigungu) b

WHERE a.sido (+) = b.sido
AND a.sigungu (+) = b.sigungu
) c, 


(SELECT id, sido, SIGUNGU, Round(SAL/ PEOPLE,1) ��������Ű��
      FROM TAX
      )d

WHERE c.sigungu (+)  = d.sigungu
ORDER By d.id

;

--�������� �����մϴٿ�
    
--smith�� ���� �μ� ã�� 
SELECT deptno
FROM emp 
WHERE ename ='SMITH';

SELECT *
FROM emp 
WHERE deptno != (SELECT deptno
                FROM emp 
                WHERE ename ='SMITH');
                
                
--SCALAR SUBQUERY
--SELECT ���� ǥ���� ��������
--�� �� , �� COLUMN�� ��ȸ�ؾ� �Ѵ�.
SELECT empno, ename, deptno,
        (SELECT dname FROM dept) dname
FROM emp;        
--INLINE VIEW
--FROM ���� ���Ǵ� ��������

--SUBQUERY
--WHERE ���� ���Ǵ� ��������


--�������� �ǽ� sub1
SELECT COUNT(*) cnt
FROM emp
WHERE SAL >(SELECT AVG(sal)
            FROM emp);


--�������� �ǽ� sub2
SELECT *
FROM emp
WHERE SAL >(SELECT AVG(sal)
            FROM emp);
            
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                   FROM emp
                   WHERE ename in('SMITH','WARD'));
                                
--SMITH Ȥ�� WARD���� �޿��� ���Թ޴� ������ȸ
SELECT *
FROM emp
WHERE sal <ANY (SELECT sal
                FROM emp
                WHERE ename in('SMITH','WARD'));
                   
                   
                   
--������ ������ �����ʴ� ��� ���� ��ȸ
--NOT IN ������ ���ÿ���
SELECT *
FROM emp -- ��� ���� ��ȸ --> ������ ������ �����ʴ�
WHERE empno NOT IN (SELECT NVL(mgr,-1)
                    FROM emp);
                         
                         
                         
SELECT *
FROM emp -- ��� ���� ��ȸ --> ������ ������ �����ʴ�
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT null);
                         


--pairwise(�����÷��� ���� ���ÿ� �����ؾ��ϴ� ���)
--ALLEN, CLEAK�� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ��� ���� ��ȸ
--(7698,30)
--(7839,10)
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499,7782))
AND deptno IN (SELECT deptno
              FROM emp
              WHERE empno IN (7499,7782));
               
               
--���ȣ���� ��������
--���������� �÷��� ������������ ������� �ʴ�  ������ ��������
--���ȣ ���� ���������� ��� ������������ ����ϴ� ���̺� , �������� ��ȸ ������ 
--���������� ������ ������ �Ǵ��Ͽ� ������ �����Ѵ�.
--���������� emp ���̺��� �������� �� �ְ�, ���������� emp ���̺��� 
--���� ���� �� �ִ�.

--���ȣ ���� ������������ �������� �� ���̺��� ���� ���� ����
--���������� ������ ������ �ߴ� ��� �� �������� ǥ��
--���ȣ ���� ������������ ���������� ���̺��� ���߿� ���� ����
--���������� Ȯ���� ������ �ߴ� ��� �� �������� ǥ��

--������ �޿� ��� ���� ���� �޿��� �޴� ���� ���� ��ȸ
--������ �޿����

sELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
            
            
             
--��ȣ���� �������� 
--�ش������� ���� �μ��� ��ձ޿����� ���� �޿��� �޴� ���� ��ȸ
SELECT *
FROM emp 
WHERE sal > (SELECT AVG(sal)
                FROM emp
                WHERE deptno = deptno);


--10�� �μ��� �޿� ���
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;