# 사내 비품 관리 시스템 (Office Inventory Management System)

> **Spring MVC와 MyBatis를 기반으로 한 사내 자산 추적 관리 솔루션**
> 비품의 효율적인 재고 관리와 사원별 대여/반납 프로세스를 전산화한 프로젝트입니다.

---

## 1. 프로젝트 개요
* **개발 배경**: 기존 수동으로 관리되던 사내 비품 현황을 전산화하여 비품의 위치와 수량을 실시간으로 추적하고, 관리 효율을 높이기 위해 제작되었습니다.
* **핵심 목표**: 
  - 비품의 실시간 재고 현황 파악 및 추적
  - 사원별 대여 이력 관리 및 반납 예정일 준수 유도
  - 데이터 보존을 위한 논리 삭제(Soft Delete) 로직 구현

---

## 2. 기술 사양 (Tech Stack)
* **Language**: Java 1.8
* **Framework**: Spring Framework 5.0.7.RELEASE
* **Database**: MySQL 8.0
* **ORM**: MyBatis
* **Server**: Apache Tomcat 9.0
* **View**: JSP, JSTL, Bootstrap 5.3

---

## 3. 데이터베이스 구조 (Table Schema)

```sql
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
    ret_exp_date DATETIME GENERATED ALWAYS AS (DATE_ADD(rent_date, INTERVAL 7 DAY)),
    ret_act_date DATETIME,
    CONSTRAINT fk_rent_emp FOREIGN KEY (emp_id) REFERENCES emp(emp_id),
    CONSTRAINT fk_rent_item FOREIGN KEY (item_id) REFERENCES item(item_id)
);
```

## 4. 주요 핵심 기능
**사원(Employee) 기능**
- 실시간 비품 조회: 현재 대여 가능한(AVAILABLE) 비품 목록과 수량을 실시간으로 조회합니다.

- 비품 대여: 재고가 있는 물품을 선택하여 대여를 신청하며, 대여 시 자동으로 재고가 차감됩니다.

- 나의 대여 현황: 본인이 대여 중인 물품 목록과 반납 예정일을 확인하고 직접 반납 처리를 수행합니다.

**관리자(Admin) 기능**
재고 관리: 신규 비품 등록 및 기존 비품의 수량, 품목명을 수정합니다.

- 논리 삭제(Soft Delete): 비품 삭제 시 DB에서 행을 삭제하지 않고 status를 deleted로 변경하여, 과거의 대여 이력이 소실되지 않게 관리합니다.

- 전체 모니터링: 모든 사원의 대여 데이터를 통합 조회하며, 반납 예정일이 지난 '연체' 항목을 시각적으로 강조(빨간색 배경)하여 관리 편의성을 높였습니다.

## 5. UI/UX 개선 사항
* **디자인 리뉴얼**: Bootstrap 5를 적용하여 텍스트 중심의 초기 화면을 현대적인 대시보드 스타일로 개편했습니다.

* **상태 시각화**: Badge와 Table-color 시스템을 도입하여 대여 가능, 품절, 연체 등의 상태를 직관적으로 구분했습니다.

* **반응형 레이아웃**: 웹 표준 환경에 맞춰 다양한 화면 크기에서도 레이아웃이 깨지지 않도록 설계했습니다.

## 6. 설치 및 실행 방법
* **1) DB 스크립트 실행**
제공된 01_create_user_my.sql 파일을 실행하여 전용 데이터베이스와 계정을 생성하고
02_create_teble_my.sql 파일을 실행하여 테이블 구조와 카테고리 기초 데이터를 생성합니다.

* **2) 프로젝트 설정 확인 (필요 시 수정)**
본 프로젝트는 기본적으로 아래 설정값을 사용합니다. 만약 다른 계정 정보를 사용하고 싶다면 해당 파일을 수정하세요.
- **파일 경로**: `src/main/resources/db.properties`
- **기본 설정값**:
  - URL: `jdbc:mysql://localhost:3306/inventory_db`
  - ID: `inventory_user`
  - PW: `123123`

* **3) 서버 실행**
IDE(STS/Eclipse)에 Tomcat 9.0 서버를 등록합니다.

프로젝트 우클릭 -> Run As -> Run on Server를 통해 실행합니다.

접속 주소: http://localhost:8080/