DROP TABLE rental CASCADE CONSTRAINTS;
DROP TABLE item CASCADE CONSTRAINTS;
DROP TABLE item_category CASCADE CONSTRAINTS;
DROP TABLE emp CASCADE CONSTRAINTS;

DROP SEQUENCE seq_cat_id;
DROP SEQUENCE seq_item_id;
DROP SEQUENCE seq_rental_id;


-- 카테고리 테이블
CREATE TABLE item_category (
    cat_id      NUMBER PRIMARY KEY,
    cat_name    VARCHAR2(50) NOT NULL
);

-- 사원 테이블 (사용자)
CREATE TABLE emp (
    emp_id      VARCHAR2(20) PRIMARY KEY,
    password    VARCHAR2(100) NOT NULL,
    name        VARCHAR2(20) NOT NULL,
    dept        VARCHAR2(20),
    role        VARCHAR2(10) DEFAULT 'USER' -- 'USER' or 'ADMIN'
);

-- 기자재 테이블 (재고)
CREATE TABLE item (
    item_id      NUMBER PRIMARY KEY,
    item_name    VARCHAR2(100) NOT NULL,
    cat_id       NUMBER,
    item_price   NUMBER,
    quantity     NUMBER DEFAULT 0,          -- [추가] 재고 수량
    status       VARCHAR2(20) DEFAULT 'AVAILABLE', 
    reg_date     DATE DEFAULT SYSDATE,      -- [추가] 등록일 (기본값 현재날짜)
    CONSTRAINT fk_item_cat FOREIGN KEY (cat_id) REFERENCES item_category(cat_id)
);

-- 대여 테이블
CREATE TABLE rental (
    rental_id    NUMBER PRIMARY KEY,
    emp_id       VARCHAR2(20),
    item_id      NUMBER,
    rent_date    DATE DEFAULT SYSDATE,
    ret_exp_date DATE,         -- 반납 예정일
    ret_act_date DATE,         -- 실제 반납일
    CONSTRAINT fk_rent_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id),
    CONSTRAINT fk_rent_item FOREIGN KEY (item_id) REFERENCES item(item_id)
);
-- 자동 증가 번호 생성기(Sequence)
CREATE SEQUENCE seq_cat_id START WITH 1;
CREATE SEQUENCE seq_item_id START WITH 1;
CREATE SEQUENCE seq_rental_id START WITH 1;

-- 테스트용 기초 데이터
INSERT INTO item_category VALUES (seq_cat_id.NEXTVAL, '노트북');
INSERT INTO item_category VALUES (seq_cat_id.NEXTVAL, '도서');
INSERT INTO item_category VALUES (seq_cat_id.NEXTVAL, '주변기기');

INSERT INTO emp VALUES ('admin', '123123', '관리자', '운영팀', 'ADMIN');
INSERT INTO emp VALUES ('user01', '123123', '홍길동', '개발팀', 'USER');

INSERT INTO item (item_id, item_name, cat_id, item_price, quantity, status) 
VALUES (seq_item_id.NEXTVAL, '맥북 에어 M3', 1, 1500000, 5, 'AVAILABLE');

INSERT INTO item (item_id, item_name, cat_id, item_price, quantity, status) 
VALUES (seq_item_id.NEXTVAL, '오라클 정복', 2, 30000, 10, 'AVAILABLE');

DELETE FROM item;

COMMIT;
-------------------------------------------------------------------------
SELECT * FROM ITEM_CATEGORY;
DELETE FROM ITEM;
DELETE FROM ITEM_CATEGORY;