### CTE, View, Table 비교

#### **1) CTE (Common Table Expression)**
- **정의**: `WITH` 절로 쿼리 내에서 정의되는 임시 결과 집합.
- **특징**:
  - 쿼리 실행 동안만 존재하며, 쿼리가 끝나면 자동으로 사라짐(메모리 내 임시).
  - 동일 쿼리 내에서 재사용 가능(가독성 및 모듈화에 유용).
  - 디스크에 저장되지 않음.
  - 재귀 쿼리(`WITH RECURSIVE`)를 지원(예: 계층적 데이터 처리).
- **사용 예**:
  ```sql
  WITH temp AS (
      SELECT student_id, COUNT(*) AS count FROM Examinations GROUP BY student_id
  )
  SELECT * FROM temp WHERE count > 1;
  ```
- **장점**:
  - 쿼리 내에서만 사용되므로 관리 부담이 없음.
  - 복잡한 쿼리를 간소화하고 가독성을 높임.
- **단점**:
  - 쿼리 외부에서 재사용 불가.
  - 대규모 데이터에서 최적화가 제한될 수 있음(PostgreSQL에서는 `MATERIALIZED` 옵션으로 보완 가능, 하지만 표준 SQL에는 없음).

#### **2) View**
- **정의**: 저장된 쿼리로, 테이블처럼 동작하는 가상 테이블.
- **특징**:
  - `CREATE VIEW`로 생성하며, 데이터베이스 스키마에 저장됨.
  - 실제 데이터를 저장하지 않고, 쿼리 실행 시 기반 테이블에서 데이터를 동적으로 가져옴.
  - 여러 쿼리에서 재사용 가능.
  - `CREATE OR REPLACE VIEW`로 수정 가능.
  - 일부 DBMS에서 `MATERIALIZED VIEW`(물리화된 뷰)를 지원해 데이터를 저장할 수도 있음(표준 SQL에는 없음).
- **사용 예**:
  ```sql
  CREATE VIEW student_exams AS
      SELECT student_id, subject_name, COUNT(*) AS attended_exams
      FROM Examinations
      GROUP BY student_id, subject_name;
  SELECT * FROM student_exams;
  ```
- **장점**:
  - 자주 사용하는 쿼리를 저장해 재사용 가능.
  - 권한 관리 및 데이터 추상화에 유용.
- **단점**:
  - 기반 테이블이 변경되면 뷰도 영향을 받음.
  - 복잡한 뷰는 성능 저하 가능성 있음.

#### **3) 테이블 생성 (Physical Table)**
- **정의**: `CREATE TABLE`로 생성되는 실제 데이터가 저장되는 물리적 테이블.
- **특징**:
  - 디스크에 데이터가 영구적으로 저장됨.
  - 인덱스, 제약 조건(예: 기본 키, 외래 키), 파티셔닝 등 다양한 기능을 지원.
  - `INSERT`, `UPDATE`, `DELETE`로 데이터 수정 가능.
  - 임시 테이블(`CREATE TEMPORARY TABLE`)은 세션 종료 시 사라짐.
- **사용 예**:
  ```sql
  CREATE TABLE student_exams (
      student_id INT,
      subject_name VARCHAR(50),
      attended_exams INT
  );
  INSERT INTO student_exams
      SELECT student_id, subject_name, COUNT(*)
      FROM Examinations
      GROUP BY student_id, subject_name;
  SELECT * FROM student_exams;
  ```
- **장점**:
  - 데이터 영구 저장 및 고급 관리 가능(인덱스, 트랜잭션 등).
  - 대규모 데이터 처리에 적합.
- **단점**:
  - 스토리지 공간 사용.
  - 데이터 유지보수(삭제, 갱신 등) 필요.

#### **비교 요약**:

| 항목           | CTE                          | View                          | 테이블 (Physical Table)         |
|----------------|------------------------------|-------------------------------|---------------------------------|
| **지속성**     | 쿼리 실행 동안만 (임시)       | 데이터베이스에 저장 (가상)     | 디스크에 영구 저장 (물리적)      |
| **저장**       | 메모리에만 저장              | 실제 데이터 저장 안 함         | 디스크에 데이터 저장             |
| **재사용**     | 동일 쿼리 내에서만           | 여러 쿼리에서 가능             | 모든 쿼리에서 가능              |
| **수정 가능**  | 불가 (쿼리 재작성 필요)       | 뷰 재정의 가능                | 데이터 삽입/수정/삭제 가능       |
| **성능**       | 소규모 데이터에 적합          | 동적 쿼리 실행으로 부하 가능    | 인덱스 등으로 최적화 가능        |
| **사용 사례**  | 복잡한 쿼리 간소화           | 자주 사용하는 쿼리 저장        | 영구 데이터 저장 및 관리         |