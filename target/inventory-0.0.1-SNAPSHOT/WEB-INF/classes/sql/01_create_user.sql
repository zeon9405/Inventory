-- 1. 사용자 생성 (아이디: inventory_user, 비밀번호: 123123)
-- 실무 팁: 프로젝트 성격이 드러나는 이름을 사용하는 것이 좋음.
CREATE USER inventory_user IDENTIFIED BY 123123;

-- 2. 접속 권한(CONNECT)과 기본적인 객체 생성 권한(RESOURCE) 부여
GRANT CONNECT, RESOURCE TO inventory_user;

-- 3. 테이블을 만들고 데이터를 저장할 수 있는 공간(TABLESPACE) 할당
-- 이 권한이 없으면 테이블 생성 시 '권한 부족' 에러가 발생할 수 있습니다.
ALTER USER inventory_user QUOTA UNLIMITED ON USERS;