
SELECT dept_h.*, LEVEL, LPAD(' ',(LEVEL-1)*3)||deptnm
FROM dept_h
START WITH deptcd='dept0' --�������� deptcd = 'dept0' -->xȸ�� �ֻ��� ����
CONNECT BY PRIOR deptcd = p_deptcd
;

SELECT LPAD('XXȸ��',15,'*')
FROM dual;

SELECT dept_h.*, LEVEL, LPAD(' ',(LEVEL-1)*3)||DEPTNM
FROM dept_h
START WITH deptcd='dept0_02' --�������� deptcd = 'dept0' -->xȸ�� �ֻ��� ����
CONNECT BY PRIOR deptcd = p_deptcd
;

SELECT *
FROM dept_h;

--��������(dept0_00_0)�� �������� ����� �������� �ۼ�
--�ڱ� �μ��� �θ� �μ��� ������ �Ѵ�.
--prior�� ���� ���� ���� ��, �� ������ ���� ���� ��
--�࿡ �ٴ� ���λ��. 
SELECT dept_h.*, LEVEL,LPAD(' ',(LEVEL-1)*3)||DEPTNM
FROM dept_h
START WITH deptcd ='dept0_00_0'
-- CONNECT BY PRIOR p_deptcd = deptcd
CONNECT BY deptcd = PRIOR p_deptcd;  --�̷������νᵵ��


SELECT deptcd,LPAD(' ',(LEVEL-1)*3)||DEPTNM deptnm, p_deptcd
FROM dept_h
START WITH deptcd ='dept0_00_0'
-- CONNECT BY PRIOR p_deptcd = deptcd
CONNECT BY deptcd = PRIOR p_deptcd;  --�̷������νᵵ��

/*
    dept0(XXȸ��)
        dept0_00(�����κ�)
            dept0_00_0������ ��.)
        dept0_01(������ȹ��)
            dept0_01_0(��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02(�����ý��ۺ�)
            dept0_02_0(����1��)
            dept0_01_0(����2��) ��ȸ
*/ 

create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all
select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;


SELECT LPAD(' ',(LEVEL-1)*3)||s_id ps_id, value
FROM h_sum
START WITH s_id ='0'
-- CONNECT BY PRIOR p_deptcd = deptcd
CONNECT BY PRIOR s_id = ps_id;  --�̷������νᵵ��

create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);

insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;

--�ǽ� h_5
SELECT LPAD(' ',(LEVEL-1)*3)||ORG_CD,NO_EMP
FROM NO_EMP
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR ORG_CD = PARENT_ORG_CD;

--pruning branch(����ġ��)
--���� ������ ���� ����
--FROM --> START WITH - CONNECT BY --> WHERE
--������ CONNECT BY ���� ����� ���
-- . ���ǿ� ���� ���� ROW�� ������ �ȵǰ� ����
--������ WHERE���� ����� ���
--. START WITH - CONNECT BY���� ���� �������� ���� ����� 
--WHERE ���� ����� ��� ���� �ش��ϴ� �����͸� ��ȸ

--�ֻ��� ��忡�� ��������� Ž��
--connect by ���� deptnm != '������ȹ��' ������ ����� ���
SELECT *
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm !='������ȹ��';

--WHERE ���� deptnm != '������ȹ��' ������ ����� ���
--���� ������ �����ϰ� ���� ��������� WHERE�������� ����
SELECT *
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

-- ���� �������� ��� ������ Ư�� �Լ�
-- CONNECT_BY_ROOT(col) ���� �ֻ��� row�� col ���� �� ��ȸ
-- SYS_CONNECT_BY_PATH(col, ������) : �ֻ��� row���� ���� �ο���� col ����
-- �����ڷ� �������� ���ڿ�(EX : XXȸ�� - �����κε�������)
-- CONNECT_BY_ISLEAF : �ش� ROW�� ������ ������� (LEAF NODE)
-- leaf node : 1, node: 0

SELECT deptcd,LPAD(' ',4*(LEVEL-1)) ||deptnm, 
       CONNECT_BY_ROOT(deptnm) croot,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm,'----'),'-') sys_path, --LƮ������ ���ʺ��� �������ڿ���������
       CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

