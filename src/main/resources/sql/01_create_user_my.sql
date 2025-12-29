-- 1. 데이터베이스(스키마) 생성 
CREATE DATABASE inventory_db;

-- 2. 사용자 생성 (아이디: inventory_user, 비밀번호: 123123)
CREATE USER 'inventory_user'@'localhost' IDENTIFIED BY '123123';

-- 3. 권한 부여
GRANT ALL PRIVILEGES ON inventory_db.* TO 'inventory_user'@'localhost';

-- 4. 변경사항 적용
FLUSH PRIVILEGES;

