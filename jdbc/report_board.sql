create table jdbc_board(
    board_no number not null,  -- 번호(자동증가)
    board_title varchar2(100) not null, -- 제목
    board_writer varchar2(50) not null, -- 작성자
    board_date date not null,   -- 작성날짜
    board_content clob,     -- 내용
    constraint pk_jdbc_board primary key (board_no)
);
create sequence board_seq
    start with 1-- 시작번호
    increment by 1; -- 증가값
    
drop sequence board_seq;    
drop table jdbc_board;
    
SELECT board_seq.CURRVAL FROM DUAL;
SELECT board_seq.NEXTVAL FROM DUAL;
    
    
    -- INSERT 시 시퀀스 사용
    INSERT INTO jdbc_board (board_no, board_title, board_writer, board_date, board_content)
    VALUES (board_seq.NEXTVAL,'TIGER', 'MANAGER',SYSDATE, 'ama');
 
    update jdbc_board set board_title = 's', board_writer = '2', board_content = '2';
                
    
    
--    -- SELECT 절에서 시퀀스 사용
--    SELECT board_seq.NEXTVAL as board_no, board_title, board_writer, board_date, board_content
--    FROM jdbc_board; 
    
    select *
    from jdbc_board;