-- PLSQL������ index�� ���ڰ� �ƴ϶� ���ڿ��� ����
-- FOR LOOP���� ������ Ŀ�� ����ϱ�
-- �μ����̺��� ��� ���� �μ��̸�, ��ġ ���� ������ ��� (CURSOR�� �̿�)
SET SERVEROUTPUT ON;
DECLARE
   -- Ŀ�� ���� 
    CURSOR dept_cursor IS
        SELECT dname, loc
        FROM dept;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    FOR record_row IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname || ', ' || record_row.loc);
    END LOOP;
END; 
/

--Ŀ������ ���ڰ� ���� ���
--
SET SERVEROUTPUT ON;
DECLARE
   -- Ŀ�� ���� 
    CURSOR dept_cursor(p_deptno dept.deptno%TYPE) IS
        SELECT dname, loc
        FROM dept
        WHERE deptno = p_deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    FOR record_row IN dept_cursor(10) LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname || ', ' || record_row.loc);
    END LOOP;
END; 
/

-- FOR LOOP �ζ��� Ŀ��
-- FOR LOOP �������� Ŀ���� ���� ����
SET SERVEROUTPUT ON;
DECLARE
BEGIN
    FOR record_row IN (SELECT dname, loc FROM dept)  LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname || ', ' || record_row.loc);
    END LOOP;
END; 
/


 CREATE TABLE DT
(	DT DATE);

insert into dt
select trunc(sysdate + 10) from dual union all
select trunc(sysdate + 5) from dual union all
select trunc(sysdate) from dual union all
select trunc(sysdate - 5) from dual union all
select trunc(sysdate - 10) from dual union all
select trunc(sysdate - 15) from dual union all
select trunc(sysdate - 20) from dual union all
select trunc(sysdate - 25) from dual;

commit;


--PRO_3
SELECT sum((to_char(dt, 'yyyymmdd'))+to_char(dt,'yyyymmdd')
FROM dt;

SELECT dt, LEAD(dt) OVER (ORDER BY dt)
FROM dt;

SELECT AVG(sum_avg) sum_avg
FROM
(SELECT lead(dt) over (ORDER BY dt) - (dt) sum_avg
FROM dt);    

SET SERVEROUTPUT ON;
DECLARE
BEGIN
    FOR sum_row IN SELECT (AVG(sum_avg) sum_avg
                FROM
                (SELECT lead(dt) over (ORDER BY dt) - (dt) sum_avg
                FROM dt))  
                        
    LOOP
        DBMS_OUTPUT.PUT_LINE(', ' || sum_row.dt);
    END LOOP;
END; 
/
--
--PRO_3(��)

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE avgdt IS
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
    v_sum NUMBER := 0;
BEGIN
    SELECT *
    BULK COLLECT INTO v_dt_tab
    FROM dt
    ORDER BY dt;

    FOR i IN 1..(v_dt_tab.count-1) LOOP
        v_sum := v_sum+v_dt_tab(i + 1).dt-v_dt_tab(i).dt;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
    
END; 
/
EXEC avgdt;

--FRO_4 
CREATE OR REPLACE PROCEDURE CREATE_DAILY_SALES
(v_yyyymm IN VARCHAR2) IS
    TYPE cal_row_type IS RECORD (
        dt VARCHAR2(8),
        day NUMBER);
    TYPE cal_tab IS TABLE OF cal_row_type INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
    -- �����ϱ����� �ش����� �ش��ϴ� �Ͻ��� �����͸� �����Ѵ�.
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
    
    -- �޷������� table ������ �����Ѵ�
    -- �ݺ����� sql ������ �����ϱ� ���� �ѹ��� �����Ͽ� ������ ����
    SELECT TO_CHAR(TO_date(v_yyyymm, 'YYYYMM')+(LEVEL-1),'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(v_yyyymm,'YYYYMM')+(LEVEL-1),'D') day
    BULK COLLECT INTO v_cal_tab       
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm,'YYYYMM')),'DD');
       
    -- �����ֱ� ������ �д´�
    FOR daily IN (SELECT * FROM cycle) LOOP
        --12�� ���ڴ޷� : cycle row �Ǽ� ��ŭ �ݺ�
        FOR i IN 1..v_cal_tab.count LOOP
            IF daily.day = v_cal_tab(i).day THEN
                --cid, pid, ����, ����
                INSERT INTO daily VALUES 
                    (daily.cid, daily.pid, v_cal_tab(i).dt, daily.cnt);
            END IF;
        END LOOP;
        SYS.DBMS_OUTPUT.PUT_LINE(daily.cid || ', '|| daily.day);
    END LOOP;
    
    commit;
END;
/
exec CREATE_DAILY_SALES('201912');

SELECT TO_CHAR(TO_date('201912', 'YYYYMM')+(LEVEL-1),'YYYYMMDD') dt,
       TO_CHAR(TO_DATE('201912','YYYYMM')+(LEVEL-1),'D') day
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('201912','YYYYMM')),'DD');


SELECT *
FROM daily
WHERE dt LIKE '201912'||'%';

SELECT *
FROM daily
WHERE dt BETWEEN '201911' || '01' AND '201911' || '31';


SELECT * FROM daily;

--66
--1�� : 0.028��

INSERT DAILY VALUES (1,100,'20191201',5);

INSERT DAILY;

SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
    (SELECT TO_CHAR(TO_date(:v_yyyymm, 'YYYYMM')+(LEVEL-1),'YYYYMMDD') dt,
            TO_CHAR(TO_DATE(:v_yyyymm,'YYYYMM')+(LEVEL-1),'D') day
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:v_yyyymm,'YYYYMM')),'DD')) cal
WHERE cycle.day = cal.day;    
    