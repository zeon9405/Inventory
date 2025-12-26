-- 사용할 데이터베이스 선택 (필수!)
USE inventory_db;

-- 1. 카테고리 테이블
CREATE TABLE item_category (
    cat_id      INT AUTO_INCREMENT PRIMARY KEY,
    cat_name    VARempCHAR(50) NOT NULL
);

-- 2. 사원 테이블
CREATE TABLE emp (
    emp_id      VARCHAR(20) PRIMARY KEY,
    password    VARCHAR(100) NOT NULL,
    name        VARCHAR(20) NOT NULL,
    dept        VARCHAR(20),
    role        VARCHAR(10) DEFAULT 'USER'
);

-- 3. 기자재 테이블
CREATE TABLE item (
    item_id      INT AUTO_INCREMENT PRIMARY KEY,
    item_name    VARCHAR(100) NOT NULL,
    cat_id       INT,
    item_price   INT,
    quantity     INT DEFAULT 0,
    status       VARCHAR(20) DEFAULT 'AVAILABLE', 
    reg_date     DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_item_cat FOREIGN KEY (cat_id) REFERENCES item_category(cat_id)
);

-- 4. 대여 테이블
CREATE TABLE rental (
    rental_id    INT AUTO_INCREMENT PRIMARY KEY,
    emp_id       VARCHAR(20),
    item_id      INT,
    rent_date    DATETIME DEFAULT CURRENT_TIMESTAMP,
    ret_exp_date DATETIME,
    ret_act_date DATETIME,
    CONSTRAINT fk_rent_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id),
    CONSTRAINT fk_rent_item FOREIGN KEY (item_id) REFERENCES item(item_id)
);

-- 사용할 데이터베이스 선택
USE inventory_db;

-- 기존 데이터 삭제 (삭제 순서는 외래 키 제약 조건을 고려하여 역순으로 진행)
DELETE FROM rental;
DELETE FROM item;
DELETE FROM emp;
DELETE FROM item_category;

-- 1. 카테고리 데이터 삽입
-- cat_id는 AUTO_INCREMENT이므로 cat_name만 입력합니다.
INSERT INTO item_category (cat_name) VALUES ('노트북');
INSERT INTO item_category (cat_name) VALUES ('도서');
INSERT INTO item_category (cat_name) VALUES ('주변기기');

-- 2. 사원 데이터 삽입
-- 컬럼명: emp_id, password, name, dept, role
INSERT INTO emp (emp_id, password, name, dept, role) 
VALUES ('admin', '123123', '관리자', '운영팀', 'ADMIN');

INSERT INTO emp (emp_id, password, name, dept, role) 
VALUES ('user01', '123123', '홍길동', '개발팀', 'USER');

-- 3. 아이템 데이터 삽입
-- cat_id는 위에서 삽입된 순서대로 1(노트북), 2(도서)가 부여됩니다.
INSERT INTO item (item_name, cat_id, item_price, quantity, status) 
VALUES ('맥북 에어 M3', 1, 1500000, 5, 'AVAILABLE');

INSERT INTO item (item_name, cat_id, item_price, quantity, status) 
VALUES ('오라클 정복', 2, 30000, 10, 'AVAILABLE');

-- 변경사항 반영
COMMIT;

-- 결과 확인
SELECT * FROM item_category;
SELECT * FROM emp;
SELECT * FROM item;

-- 5. 변경사항 반영
-- MySQL은 기본적으로 Autocommit 설정이 되어 있으나, 
-- 명시적 트랜잭션 사용 시 필요합니다.
COMMIT;

SELECT * FROM item_category;
SELECT * FROM emp;