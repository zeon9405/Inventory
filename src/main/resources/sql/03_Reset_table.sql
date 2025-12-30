---------------------------------
-- 테이블 구조는 유지하고 싶을때

-- 1. 외래 키 제약 조건 체크를 비활성화
SET FOREIGN_KEY_CHECKS = 0;
-- 2. 테이블을 비우기
truncate table rental;
truncate table item;
truncate table emp;
truncate table item_category;
-- 3. 외래 키 제약 조건 체크를 다시 활성화
SET FOREIGN_KEY_CHECKS = 1;

----------------------------------
-- 테이블 자체를 전부 지울때

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS rental;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS item_category;
DROP TABLE IF EXISTS emp;
-- 테이블 재생성
SET FOREIGN_KEY_CHECKS = 1;