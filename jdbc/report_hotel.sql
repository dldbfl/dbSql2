create table hotel( room_num NUMBER, ghest_name VARCHAR2(50));
                    
drop table hotel;                    

SELECT * FROM hotel;

delete from hotel
where room_num;

delete from hotel where room_num = 101;
select * from hotel where room_num = 100;

select * from lprod where lprod_gu ='' or 1=1 --'and lprod_nm='��깰';
;

--lprod ������ ���̺�
delete from lprod where lprod_id > 9;
commit;


? = scan.next();
select * from lprod
where jdpbbord_title = '?';

rs.next()

getString("LPROD_NM")
select MAX(lprod_id) l from lprod;
---



create table mymember(
    mem_id varchar2(8) not null,  -- ȸ��ID
    mem_name varchar2(100) not null, -- �̸�
    mem_tel varchar2(50) not null, -- ��ȭ��ȣ
    mem_addr varchar2(128)    -- �ּ�
);

commit;

select * from mymember;



update mymember set mem_name = ?, set mem_tel = ?, mem_addr =?
where mem_id = ?




SELECT * FROM user_sequences WHERE SEQUENCE_NAME = 'board_seq';
SELECT * FROM jdbc_board;


create table jdbc_board(
    board_no number not null,  -- ��ȣ(�ڵ�����)
    board_title varchar2(100) not null, -- ����
    board_writer varchar2(50) not null, -- �ۼ���
    board_date date not null,   -- �ۼ���¥
    board_content clob,     -- ����
    constraint pk_jdbc_board primary key (board_no)
);
create sequence board_seq
    start with 1-- ���۹�ȣ
    increment by 1; -- ������
    
drop sequence board_seq;    

drop table jdbc_board;
    
    INSERT INTO board_seq(NUM, NAME, TITLE) VALUES (board_seq.NEXTVAL, 'ȫ�浿', '����');
    board_seq.nextVAL;  
    
    SELECT board_seq.CURRVAL FROM DUAL;
    
    SELECT board_seq.NEXTVAL FROM DUAL;
    
    
    -- INSERT �� ������ ���
    INSERT INTO jdbc_board (board_no, board_title, board_writer, board_date, board_content)
    VALUES (board_seq.NEXTVAL,'TIGER', 'MANAGER',SYSDATE, 'ama');
 
    
    -- SELECT ������ ������ ���
    SELECT board_seq.NEXTVAL as board_no, board_title, board_writer, board_date, board_content
    FROM jdbc_board; 