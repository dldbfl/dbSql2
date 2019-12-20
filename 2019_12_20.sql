--PL/SQL
--PL/SQL �⺻����
--DECLARE : �����, ������ �����ϴ� �κ�
--BEGIN : PL/SQL�� ������ ���� �κ�
--EXCEPTION : ����ó����

--DBMS_OUTPUT.PUT_LINE �Լ��� ����ϴ� ����� ȭ�鿡 �����ֵ��� Ȱ��ȭ
SET SERVEROUTPUT ON;
DECLARE  --�����
 --java : Ÿ�� ������
 --pl/sql : ������ Ÿ��
--     v_dname VARCHAR2(14);
--     v_loc VARCHAR2(13);
    --���̺� �÷��� ���Ǹ� �����Ͽ� ������ Ÿ���� �����Ѵ�.
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;

BEGIN
    --DEPT ���̺��� 10�� �μ��� �μ� �̸�, LOC ������ ��ȸ
    SELECT dname, loc
    INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    --String a = 5
    --String b = 10;
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc);
END;
/   
--PL/SQL ����� ����

--10�� �μ��� �μ��̸�, ��ġ������ ��ȸ�ؼ� ������ ���
--������ DBMS_OUTPUT.PUT_LINE�Լ��� �̿��Ͽ� console�� ���
CREATE OR REPLACE PROCEDURE printdept 
--�Ķ���͸� IN/OUT Ÿ��
-- p_�Ķ�����̸�
( p_deptno IN dept.deptno%TYPE )
IS
--�����(�ɼ�)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;    

--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
 
    DBMS_OUTPUT.PUT_LINE(dname||' '||loc );   
--����ó����(�ɼ�)
END;
/

exec PRINTDEPT(20);

SELECT empno
FROM emp;



CREATE OR REPLACE PROCEDURE printtemp 
(param IN emp.empno%TYPE)
IS
ename emp.ename%TYPE;
dname dept.dname%TYPE;

BEGIN 
    SELECT ename, dname
    INTO ename, dname
    FROM emp, dept
    WHERE emp.deptno = dept.deptno
    AND empno = param;
    
    DBMS_OUTPUT.PUT_LINE(ename || ' ' || dname);
    
END;
/

exec PRINTTEMP(7654);

--PRO_2
CREATE OR REPLACE PROCEDURE registdept_test
(param IN dept.deptno%TYPE, param1 IN dept.dname%TYPE, param2 IN dept.loc%TYPE)
IS
deptno dept.deptno%TYPE;
dname dept.dname%TYPE;
loc dept.loc%TYPE;

BEGIN
    INSERT INTO dept_test VALUES (91, 'ddit', 'daejeon');
    COMMIT;
    SELECT deptno, dname, loc
    INTO deptno, dname, loc
    FROM dept_test
    WHERE deptno = param
    AND dname = param1
    AND loc = param2;
    
     DBMS_OUTPUT.PUT_LINE(deptno || ' ' || dname|| ' ' ||loc);
     
END;   
/

EXEC REGISTDEPT_TEST(91,'ddit','daejeon');