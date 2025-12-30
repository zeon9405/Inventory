
USE inventory_db;

-- 1. 카테고리 테이블
CREATE TABLE item_category (
    cat_id      INT AUTO_INCREMENT PRIMARY KEY,
    cat_name    VARCHAR(50) NOT NULL
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
    ret_exp_date DATETIME GENERATED ALWAYS AS (DATE_ADD(rent_date, INTERVAL 7 DAY)) STORED,
    ret_act_date DATETIME,
    CONSTRAINT fk_rent_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id),
    CONSTRAINT fk_rent_item FOREIGN KEY (item_id) REFERENCES item(item_id)
);

-- 1. 카테고리 테스트 데이터 삽입
INSERT INTO item_category (cat_name) VALUES ('노트북');
INSERT INTO item_category (cat_name) VALUES ('도서');
INSERT INTO item_category (cat_name) VALUES ('주변기기');

-- 2. 사원 테스트 데이터 삽입
INSERT INTO emp (emp_id, password, name, dept, role) 
VALUES ('admin', '123123', '관리자', '운영팀', 'ADMIN');

INSERT INTO emp (emp_id, password, name, dept, role) 
VALUES ('user01', '123123', '홍길동', '개발팀', 'USER');

-- 3. 아이템 테스트 데이터 삽입
INSERT INTO item (item_name, cat_id, item_price, quantity, status) 
VALUES ('맥북', 1, 1500000, 5, 'AVAILABLE');

INSERT INTO item (item_name, cat_id, item_price, quantity, status) 
VALUES ('혼자 공부하는 자바', 2, 30000, 10, 'AVAILABLE');

COMMIT;