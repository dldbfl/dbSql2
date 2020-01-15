create table hotel( room_num NUMBER, ghest_name VARCHAR2(50));
                    
drop table hotel;                    

SELECT * FROM hotel;

delete from hotel
where room_num;

delete from hotel where room_num = 101;
select * from hotel where room_num = 100;

select * from lprod where lprod_gu ='' or 1=1 --'and lprod_nm='축산물';
;

--lprod 연습용 테이블
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
    mem_id varchar2(8) not null,  -- 회원ID
    mem_name varchar2(100) not null, -- 이름
    mem_tel varchar2(50) not null, -- 전화번호
    mem_addr varchar2(128)    -- 주소
);

commit;

select * from mymember;



update mymember set mem_name = ?, set mem_tel = ?, mem_addr =?
where mem_id = ?




SELECT * FROM user_sequences WHERE SEQUENCE_NAME = 'board_seq';
SELECT * FROM jdbc_board;


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
    
    INSERT INTO board_seq(NUM, NAME, TITLE) VALUES (board_seq.NEXTVAL, '홍길동', '제목');
    board_seq.nextVAL;  
    
    SELECT board_seq.CURRVAL FROM DUAL;
    
    SELECT board_seq.NEXTVAL FROM DUAL;
    
    
    -- INSERT 시 시퀀스 사용
    INSERT INTO jdbc_board (board_no, board_title, board_writer, board_date, board_content)
    VALUES (board_seq.NEXTVAL,'TIGER', 'MANAGER',SYSDATE, 'ama');
 
    
    -- SELECT 절에서 시퀀스 사용
    SELECT board_seq.NEXTVAL as board_no, board_title, board_writer, board_date, board_content
    FROM jdbc_board; 