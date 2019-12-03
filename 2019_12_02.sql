-- OUTER join : ���� ���ῡ ���� �ϴ��� ������ �Ǵ� ���̺��� �����ʹ�
-- �������� �ϴ� join
-- LEFT OUTER JOIN : ���̺�1 LEFT OUTER JOIN ���̺�2
-- ���̺� 1�� ���̺�2 �� �����Ҷ�, ���ο� �����ϴ��� ���̺�1�ʿ� �����ʹ� ��ȸ�� �ǵ����Ͽ�.
-- ���ο� ������ �࿡�� ���̺�2�� �÷����� �������� �����Ƿ� NULL�� ǥ�õǿ�.

SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename,e.DEPTNO ,m.empno, m.ename , m.DEPTNo
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10);

SELECT e.empno, e.ename,e.DEPTNO ,m.empno, m.ename , m.DEPTNo
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno 
WHERE m.deptno = 10;


--ansi
-- ���� LEFT OUTER JOIN �Ŵ���
--ON (����.�Ŵ�����ȣ = �Ŵ���.������ȣ)

SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
--oracle
--�Ϲ����ΰ� �������� �÷��� (+)ǥ��
--(+)ǥ�� : �����Ͱ� �������� �ʴµ� ���;� �ϴ� ���̺��� �÷�
-- ���� LEFT OUTER JOIN �Ŵ���
--ON (����.�Ŵ�����ȣ = �Ŵ���.������ȣ) -- �Ŵ��� �� �����Ͱ� �������� ����
SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e , emp m 
WHERE e.mgr   = m.empno(+);

--�Ŵ��� �μ���ȣ ����
--*�ƿ��� ������ ����Ǿ�� �ϴ� ��� �÷��� (+)�� �پ�� �ȴ�.
SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e , emp m 
WHERE e.mgr   = m.empno(+)
AND m.DEPTNO (+)= 10;

--emp ���̺��� 14���� ������ �ְ� 14���� 10, 20 ,30�μ��߿� �� �μ��� ���Ѵ�.
--������ dept���̺��� 10, 20 ,30 , 40�� �μ��� ����
--�μ���ȣ, �μ���, �ش�μ��� ���� �������� �������� ������ �ۼ�
select * from dept;
select * from emp;

SELECT dept.deptno, dname, count(empno)
FROM emp, dept
WHERE emp.deptno (+)= dept.deptno 
GROUP BY dept.deptno, dname
ORDER BY dept.deptno;

--dept : deptno, dname
--inlin : deptno, cnt(������ ��)
SELECT dept.deptno, dept.dname,NVL(emp_cnt.cnt,0)cnt
FROM dept,
(SELECT emp.deptno, count(*) cnt
FROM emp
GROUP BY deptno)emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);

SELECT dept.deptno, dept.dname,NVL(emp_cnt.cnt,0)cnt
FROM dept LEFT OUTER JOIN (SELECT emp.deptno, count(*) cnt
                            FROM emp
                            GROUP BY deptno)emp_cnt
                        ON dept.deptno = emp_cnt.deptno(+);

-- RIGHT OUTER JOIN
 
SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ������� �ѰǸ� �����
SELECT e.empno, e.ename,m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

--outerjoiun1
SELECT * FROM buyprod;
SELECT * FROM prod;

SELECT TO_CHAR(buy_date,'YY/MM/DD')buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod, prod
WHERE buy_prod (+)= prod_id
AND buy_date(+) = to_date('20050125');

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

SELECT nvl(cycle.PID,product.pid)pid, PNM, nvl(CID,1)cid,nvl(DAY,0)day, nvl(CNT,0)cnt
FROM cycle, product
WHERE cycle.pid (+)= product.pid 
AND cid (+)= 1;

--outerjoin 5
SELECT * FROM cycle;
SELECT * FROM product;
SELECT * FROM customer;

SELECT cycle.PID, PNM, customer.CID, customer.cnm,day, cnt
FROM cycle, product, customer
WHERE cycle.pid= product.pid 
AND customer.cid = 1
AND cycle.cid  = customer.cid ;
ORDER BY cycle.pid DESC;