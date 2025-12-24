-- 1. 데이터베이스(스키마) 생성 
-- 오라클의 유저가 곧 스키마인 것과 달리, MySQL은 공간을 먼저 만들어야 합니다.
CREATE DATABASE inventory_db;

-- 2. 사용자 생성 (아이디: inventory_user, 비밀번호: 123123)
-- 'localhost'는 이 컴퓨터에서만 접속 가능하다는 뜻입니다.
CREATE USER 'inventory_user'@'localhost' IDENTIFIED BY '123123';

-- 3. 권한 부여 (inventory_db에 대한 모든 권한 부여)
-- 오라클의 CONNECT, RESOURCE와 유사한 역할을 합니다.
GRANT ALL PRIVILEGES ON inventory_db.* TO 'inventory_user'@'localhost';

-- 4. 변경사항 적용
FLUSH PRIVILEGES;

