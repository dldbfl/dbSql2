desc users;



/* �Խ��� */
DROP TABLE board 
	CASCADE CONSTRAINTS;

/* ����� */
DROP TABLE users 
	CASCADE CONSTRAINTS;

/* �Խñ� */
DROP TABLE post 
	CASCADE CONSTRAINTS;

/* ��� */
DROP TABLE reply 
	CASCADE CONSTRAINTS;

/* ÷������ */
DROP TABLE attachfile 
	CASCADE CONSTRAINTS;

/* �Խ��� ������ */
DROP SEQUENCE seq_board;

/* �Խñ� ������ */
DROP SEQUENCE seq_post;

/* ��� ������ */
DROP SEQUENCE seq_reply;

/* ÷������ ������ */
DROP SEQUENCE seq_attachfile;

/* �Խ��� ������ */
CREATE SEQUENCE seq_board;

/* �Խñ� ������ */
CREATE SEQUENCE seq_post;

/* ��� ������ */
CREATE SEQUENCE seq_reply;

/* ÷������ ������ */
CREATE SEQUENCE seq_attachfile;

/* �Խ��� */
CREATE TABLE board (
	borad_id NUMBER NOT NULL, /* �Խ���ID */
	nm VARCHAR(150) NOT NULL, /* �Խ����̸� */
	ac_yn VARCHAR2(1) DEFAULT 'Y' NOT NULL, /* Ȱ������ */
	reg_id VARCHAR2(20) NOT NULL, /* �ۼ��� */
	reg_dt DATE NOT NULL /* �ۼ��Ͻ� */
);

COMMENT ON TABLE board IS '�Խ���';

COMMENT ON COLUMN board.borad_id IS '�Խ���ID';

COMMENT ON COLUMN board.nm IS '�Խ����̸�';

COMMENT ON COLUMN board.ac_yn IS 'Ȱ������';

COMMENT ON COLUMN board.reg_id IS '�ۼ���';

COMMENT ON COLUMN board.reg_dt IS '�ۼ��Ͻ�';

CREATE UNIQUE INDEX PK_board
	ON board (
		borad_id ASC
	);

ALTER TABLE board
	ADD
		CONSTRAINT PK_board
		PRIMARY KEY (
			borad_id
		);

/* ����� */
CREATE TABLE users (
	userid VARCHAR2(20) NOT NULL, /* ����ھ��̵� */
	pass VARCHAR2(20), /* ��й�ȣ */
	usernm VARCHAR2(20), /* ������̸� */
	alias VARCHAR2(20) /* ���� */
);

COMMENT ON TABLE users IS '�����';

COMMENT ON COLUMN users.userid IS '����ھ��̵�';

COMMENT ON COLUMN users.pass IS '��й�ȣ';

COMMENT ON COLUMN users.usernm IS '������̸�';

COMMENT ON COLUMN users.alias IS '����';

CREATE UNIQUE INDEX PK_users
	ON users (
		userid ASC
	);

ALTER TABLE users
	ADD
		CONSTRAINT PK_users
		PRIMARY KEY (
			userid
		);

/* �Խñ� */
CREATE TABLE post (
	id NUMBER NOT NULL, /* �Խñ۹�ȣ */
	borad_id NUMBER NOT NULL, /* �Խ���ID */
	p_id NUMBER, /* �θ�Խñ۹�ȣ */
	title VARCHAR2(300) NOT NULL, /* ���� */
	cont CLOB NOT NULL, /* ���� */
	del_yn VARCHAR2(1) DEFAULT 'Y' NOT NULL, /* �������� */
	reg_id VARCHAR2(20) NOT NULL, /* �ۼ��� */
	reg_dt DATE NOT NULL /* �ۼ��Ͻ� */
);

COMMENT ON TABLE post IS '�Խñ�';

COMMENT ON COLUMN post.id IS '�Խñ۹�ȣ';

COMMENT ON COLUMN post.borad_id IS '�Խ���ID';

COMMENT ON COLUMN post.p_id IS '�θ�Խñ۹�ȣ';

COMMENT ON COLUMN post.title IS '����';

COMMENT ON COLUMN post.cont IS '����';

COMMENT ON COLUMN post.del_yn IS '��������';

COMMENT ON COLUMN post.reg_id IS '�ۼ���';

COMMENT ON COLUMN post.reg_dt IS '�ۼ��Ͻ�';

CREATE UNIQUE INDEX PK_post
	ON post (
		id ASC
	);

ALTER TABLE post
	ADD
		CONSTRAINT PK_post
		PRIMARY KEY (
			id
		);

/* ��� */
CREATE TABLE reply (
	ID NUMBER NOT NULL, /* ���ID */
	b_id NUMBER NOT NULL, /* �Խñ�ID */
	cont VARCHAR2(1500) NOT NULL, /* ���� */
	reg_id VARCHAR2(20) NOT NULL, /* �ۼ��� */
	reg_dt DATE NOT NULL /* �ۼ��Ͻ� */
);

COMMENT ON TABLE reply IS '���';

COMMENT ON COLUMN reply.ID IS '���ID';

COMMENT ON COLUMN reply.b_id IS '�Խñ�ID';

COMMENT ON COLUMN reply.cont IS '����';

COMMENT ON COLUMN reply.reg_id IS '�ۼ���';

COMMENT ON COLUMN reply.reg_dt IS '�ۼ��Ͻ�';

CREATE UNIQUE INDEX PK_reply
	ON reply (
		ID ASC
	);

ALTER TABLE reply
	ADD
		CONSTRAINT PK_reply
		PRIMARY KEY (
			ID
		);

/* ÷������ */
CREATE TABLE attachfile (
	id NUMBER NOT NULL, /* ÷�����Ϲ�ȣ */
	b_id NUMBER NOT NULL, /* �Խñ۹�ȣ */
	nm VARCHAR2(500) NOT NULL /* ÷�����ϸ� */
);

COMMENT ON TABLE attachfile IS '÷������';

COMMENT ON COLUMN attachfile.id IS '÷�����Ϲ�ȣ';

COMMENT ON COLUMN attachfile.b_id IS '�Խñ۹�ȣ';

COMMENT ON COLUMN attachfile.nm IS '÷�����ϸ�';

CREATE UNIQUE INDEX PK_attachfile
	ON attachfile (
		id ASC
	);

ALTER TABLE attachfile
	ADD
		CONSTRAINT PK_attachfile
		PRIMARY KEY (
			id
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_users_TO_board
		FOREIGN KEY (
			reg_id
		)
		REFERENCES users (
			userid
		);

ALTER TABLE post
	ADD
		CONSTRAINT FK_users_TO_post
		FOREIGN KEY (
			reg_id
		)
		REFERENCES users (
			userid
		);

ALTER TABLE post
	ADD
		CONSTRAINT FK_board_TO_post
		FOREIGN KEY (
			borad_id
		)
		REFERENCES board (
			borad_id
		);

ALTER TABLE post
	ADD
		CONSTRAINT FK_post_TO_post
		FOREIGN KEY (
			p_id
		)
		REFERENCES post (
			id
		);

ALTER TABLE reply
	ADD
		CONSTRAINT FK_users_TO_reply
		FOREIGN KEY (
			reg_id
		)
		REFERENCES users (
			userid
		);

ALTER TABLE reply
	ADD
		CONSTRAINT FK_post_TO_reply
		FOREIGN KEY (
			b_id
		)
		REFERENCES post (
			id
		);

ALTER TABLE attachfile
	ADD
		CONSTRAINT FK_post_TO_attachfile
		FOREIGN KEY (
			b_id
		)
		REFERENCES post (
			id
		);
        
        
        