--row_1 : emp ���̺��� ���ľ��� ROWNUM�� 1~10�� �ุ ��ȸ

SELECT ROWNUM empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


SELECT ROWNUM, a.* 
FROM
(SELECT ROWNUM rn, empno, ename  
FROM emp)a
WHERE rn BETWEEN 11 AND 14;


--row_3
SELECT b.*
FROM(SELECT ROWNUM rn, a.*
    FROM(SELECT ROWNUM empno, ename
                FROM emp
                ORDER By ename)a) b
WHERE rn BETWEEN 11 AND 14;

SELECT b.*
FROM(SELECT ROWNUM rn, a.*
        FROM (SELECT empno, ename
                FROM emp
                ORDER BY ename)a )b
WHERE rn IN (11,14);      
-------fuck you.


--DUAL ���̺� : sys ������ �ִ� ������ ��밡���� ���̺��̸�, 
--�����ʹ� ���ุ �����ϸ� �÷�(dummy)�� �ϳ� �����Ѵ�.

SELECT *
FROM dual;

--SUNGLE ROW FUNCTION : ��� �ѹ��� FUNCTION�� ����
-- 1���� �� INPUT -> 1���� ������ OUTPUT (COLUMN)
-- 'Hello, World'

SELECT LOWER ('Hello, World'),UPPER('Hello, World'),INITCAP('Hello, World')
FROM emp;

SELECT empno, LOWER (ename) low_enm    
FROM emp
WHERE ename = UPPER('smith');

--���̺� �÷��� �����ص� ������ ����� ������ ������,
--���̺� �÷����ٴ� ������� �����ϴ� ���� �ӵ��鿡�� ����
--�ش� �÷��� �ε����� �����ϴ��� �Լ��� �����ϰ� �Ǹ� ���� �޶����� �Ǿ�
--�ε����� Ȱ���� �� ���� �ȴ�.
--���� : FBI(Function Based Index)

SELECT empno, LOWER (ename) low_enm    
FROM emp
WHERE LOWER(ename) = 'smith';

SELECT UPPER ('smith')
FROM dual;

--HELLO
--,
--WORLD
--HELLO, WORLD (�� 3���� ���ڿ� ����� �̿�, CONCAT �Լ��� ����Ͽ� ���ڿ� ����)

SELECT CONCAT(CONCAT('HELLO', ', '),'WORLD') c1,
        'HELLO'||', '||'WORLD' c2,
        --�����ε����� 1���� , �����ε��� ���ڿ����� �����Ѵ�. (�ڹٴ� 0���� ���� �ε�����������. ���� �ٸ��� �����Ұ�
        SUBSTR('HELLO, WORLD', 1, 8)i1, --SUBSTR ���ڿ�, �����ε���, �����ε���
        
        --INSTR :���ڿ��� Ư�� ���ڿ��� �����ϴ���, ������ ��� ������ �ε����� ����
        INSTR('HELLO, WORLD', 'O')i2,  --5, 9
        --'HELLO, WORLD'���ڿ��� 6��° �ε��� ���Ŀ� �����ϴ� 'O'���ڿ��� �ε��� ����
        INSTR('HELLO, WORLD', 'O', 6)i3,-- ���ڿ��� Ư�� �ε��� ���ĺ��� �˻��ϵ��� �ɼ�
        
        --L>RPAD Ư�����ڿ��� ����/�����ʿ� ������ ���ڿ� ���̺��� ������ ��ŭ ä�� �ִ´�.
        LPAD('HELLO, WORLD',15,'*') L1,
        LPAD('HELLO, WORLD',15) L2, --delfault ä�� ���ڴ� �����̴�.
        RPAD('HELLO, WORLD',15,'*') R1,
        
        --REPLACE( ����ڿ�, �˻� ���ڿ�, ������ ���ڿ�)
        --����ڿ����� �˻� ���ڿ��� ������ ���ڿ��� ġȯ
        REPLACE('HELLO, WORLD','HELLO','hello') repl, --hello, WORLD
        
        --���ڿ� ��, ���� ������ ����
        '   HELLO, WORLD    'before_trim,
        TRIM('   HELLO, WORLD    ') after_trim,
        TRIM('H' FROM 'HELLO, WORLD    ') after_trim2
        
        --��͵��� �����. ������ �װŴ�
               
FROM dept; 


--���� �����Լ�
--ROUND : �ݿø� - ROUND(����, �ݿø� �ڸ�)
--TRUNC : ���� - TRUNC(����, ����)
--MOD : ������ ���� MOD (��������, ����) //MOD(5, 2) : 1

SELECT -- �ݿø� ����� �Ҽ��� ���ڸ����� ��������( �Ҽ��� ��°�ڸ����� �ݿø�)
        ROUND(105.54, 1) r1,
        ROUND(105.55, 1) r2,
        ROUND(105.55, 0) r3, -- �Ҽ��� ù��° �ڸ����� �ݿø�
        ROUND(105.54, -1) r4 -- �����ڸ����� �ݿø�
        
        
FROM dual;

SELECT -- ���� ����� �Ҽ��� ���ڸ����� ��������( �Ҽ��� ��°�ڸ����� ����)
        TRUNC(105.54, 1) t1,
        TRUNC(105.55, 1) t2,
        TRUNC(105.55, 0) t3, -- �Ҽ��� ù��° �ڸ����� ����
        TRUNC(105.54, -1) t4 -- �����ڸ����� ����
        
        
FROM dual;

--MOD (������, ����) �������� ������ ���� �������� ��
--MDO (5, 2) �� ��� ���� : 1��

SELECT MOD (5, 2) M1
FROM dual;

--emp ���̺��� sal �÷��� 1000���� �������� ����� ������ ���� ��ȸ�ϴ� sql �ۼ�
--ename, sal. sal/1000�� ���� ��, sal/1000�� ���� ������

SELECT ename, sal, TRUNC(sal/1000) ��, MOD (sal, 1000) s1,
        TRUNC(sal/1000)+ MOD (sal, 1000) sal2
FROM emp;


--DATE: �����, �ð�, ��, ��
SELECT ename, hiredate, TO_CHAR(hiredate, 'YYYY_MM_DD hh24!mi!ss') --yyyy/mm/dd

FROM emp;

--SYSDATE : ������ ���� DATE�� �����ϴ� �����Լ�, Ư���� ���ڰ� ����. 
--DATE ���� DATE + ����N = DATE�� N���� ��ŭ ���Ѵ�.
--DATE ���꿡 �־ ������ ����
--�Ϸ�� 24�ð�
--DATE Ÿ�Կ� �ð��� ���� ���� �ִ�. 1�ð� = 1/24
SELECT TO_CHAR(SYSDATE + 5, 'YYYY-MM-DD hh24:mi:ss')AFTER5_DAYS,
       TO_CHAR(SYSDATE + 5/24, 'YYYY-MM-DD hh24:mi:ss')AFTER5_HOUR,
       TO_CHAR(SYSDATE + 5/24/60, 'YYYY-MM-DD hh24:mi:ss')AFTER5_min

FROM dual;

--Function (date �ǽ� fn1)

SELECT TO_DATE('2019-12-31','yy_mm_dd') lastday1,
       TO_CHAR(TO_DATE('20191231'),'YY/MM/DD') LASTDAY,
       TO_DATE('20191231', 'YY/MM/DD')-5 LASTDAT_BEFORE5,
       SYSDATE NOW,
       SYSDATE-5 NOW_BEFORE3
       
FROM dual
;

--YYYY, MM, DD, D(������ ���ڷ� : �Ͽ���=1, ������=2, ȭ����=3......����� =7
--IW(����), HH, MI, SS

SELECT TO_CHAR(SYSDATE, 'YYYY') YYYY --����⵵
        ,TO_CHAR(SYSDATE, 'MM') MM --�����
       ,TO_CHAR(SYSDATE, 'DD') DD --������
       ,TO_CHAR(SYSDATE, 'D') DAY --�������(�ְ����� 1-7)
       ,TO_CHAR(SYSDATE, 'IW') IW --���������� ����
        , TO_CHAR(  TO_DATE('20191231','YYYYMMDD')  ,   'IW') IW2 --����⵵
       

FROM dual;    
       
           
           
--function 2 fn2
SELECT
TO_CHAR(SYSDATE,'yyyy-mm-dd') DT_DASH,
TO_CHAR(SYSDATE, 'YYYY-mm-dd hh24:mi:ss') DT_DASH_WITH_TIME,
TO_CHAR(SYSDATE, 'dd-mm-yyyy') DT_DD_MM_YYYY

FROM dual;


--DATE Ÿ���� ROUND, TRUNC ����
SELECT TO_CHAR (SYSDATE, 'YYYy-mm-dd hh24:mi:ss') now,
    TO_CHAR (ROUND(SYSDATE,'YYYY'), 'YYYy-mm-dd hh24:mi:ss') now2,  --11->1
    TO_CHAR (ROUND(SYSDATE,'MM'), 'YYYy-mm-dd hh24:mi:ss') now3,    --25->1
    TO_CHAR (ROUND(SYSDATE,'dd'), 'YYYy-mm-dd hh24:mi:ss') now4
FROM dual;    
--DATE Ÿ����  TRUNC ����
SELECT TO_CHAR (SYSDATE, 'YYYy-mm-dd hh24:mi:ss') now,
    TO_CHAR (TRUNC(SYSDATE,'YYYY'), 'YYYy-mm-dd hh24:mi:ss') now2,  --11->1
    TO_CHAR (TRUNC(SYSDATE,'MM'), 'YYYy-mm-dd hh24:mi:ss') now3,    --25->1
    TO_CHAR (TRUNC(SYSDATE,'dd'), 'YYYy-mm-dd hh24:mi:ss') now4
FROM dual;    

--��¥ ���� �Լ�
--MONTHS_BETWEEN (date1, date2) : date2�� date1 ������ ������ 
--ADD_MONTHS(date, ������ ������) : date���� Ư�� ���� ���� ���ϰų� �A ��¥
--NEXT_DAY(date, weekday(1~7)): date ���� ù weekday ��¥
--LAST_DAY(date) : date�� ���� ���� ������ ��¥


--MONTHS_BETWEEN (date1, date2)
SELECT MONTHS_BETWEEN(TO_DATE('2019-11-25', 'YYYY-MM-dd'),
                       TO_DATE('2019-03-31','yyyy-mm-dd')) m_bet,
        TO_DATE('2019-11-25', 'yyyy-mm-dd') -
        TO_DATE('2019-03-31', 'yyyy-mm-dd') d_m -- �� ��¥ ������ ���ڼ�
FROM dual;

--ADD_MONTHS ( date, number(+,-) )
SELECT ADD_MONTHS( TO_DATE('20191125','YYYYMMDD'), 5) NOW_AFTER5M,
        ADD_MONTHS( TO_DATE('20191125','YYYYMMDD'), -5) NOW_BEFORE5M
        ,SYSDATE + 100 --100�ϵ��� ��¥        
FROM dual;        

--NEXT_DAY (date, weekday number(1~7))
SELECT NEXT_DAY(SYSDATE, 7) -- ���� ��¥ (2019/11/25)�� ���� �����ϴ� ù��° �����
FROM dual;
