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
    
SELECT board_seq.CURRVAL FROM DUAL;
SELECT board_seq.NEXTVAL FROM DUAL;
    
    
    -- INSERT �� ������ ���
    INSERT INTO jdbc_board (board_no, board_title, board_writer, board_date, board_content)
    VALUES (board_seq.NEXTVAL,'TIGER', 'MANAGER',SYSDATE, 'ama');
 
    update jdbc_board set board_title = 's', board_writer = '2', board_content = '2';
                
    
    
--    -- SELECT ������ ������ ���
--    SELECT board_seq.NEXTVAL as board_no, board_title, board_writer, board_date, board_content
--    FROM jdbc_board; 
    
    select *
    from jdbc_board;