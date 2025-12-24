-- 사용할 데이터베이스 선택 (필수!)
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
    ret_exp_date DATETIME,
    ret_act_date DATETIME,
    CONSTRAINT fk_rent_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id),
    CONSTRAINT fk_rent_item FOREIGN KEY (item_id) REFERENCES item(item_id)
);

SELECT * FROM item_category;
SELECT * FROM emp;