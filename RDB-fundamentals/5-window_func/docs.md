### 기본 윈도우 함수 사용법

| **윈도우 함수**       | **설명**                                                                 | **사용법**                                                                                       |
|-----------------------|--------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| **RANK()**            | 동일 값에 같은 순위 부여, 다음 순위 건너뜀 (예: 1, 1, 3).              | `RANK() OVER (PARTITION BY customer_id ORDER BY order_date)`                                     |
| **DENSE_RANK()**      | 동일 값에 같은 순위 부여, 다음 순위 연속 (예: 1, 1, 2).                | `DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY order_date)`                               |
| **ROW_NUMBER()**      | 동일 값에도 고유 순위 부여 (예: 1, 2, 3).                              | `ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date)`                               |
| **FIRST_VALUE()**     | 파티션 내 `ORDER BY` 기준 첫 번째 값 반환.                              | `FIRST_VALUE(column) OVER (PARTITION BY customer_id ORDER BY order_date)`                        |
| **MIN() (윈도우)**    | 파티션 내 최소값 반환.                                                  | `MIN(column) OVER (PARTITION BY customer_id)`                                                   |

### 조건 표현식을 포함한 윈도우 함수 사용법

| **방법**                     | **설명**                                                                 | **사용법**                                                                                       |
|------------------------------|--------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| **조건 절 (FILTER)**         | 집계 윈도우 함수 내 조건 적용 (PostgreSQL).                              | `COUNT(*) FILTER (WHERE condition) OVER (PARTITION BY customer_id)`                              |
| **조건 절 (서브쿼리)**       | 서브쿼리 내 `WHERE`로 윈도우 함수 결과 필터링.                          | `SELECT * FROM (SELECT ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn FROM table) t WHERE rn = 1` |
| **조건 표현식 (인자)**       | 윈도우 함수 인자에 비교/조건 표현식 사용 (값 반환 함수에 적용).         | `FIRST_VALUE(order_date = customer_pref_delivery_date) OVER (PARTITION BY customer_id ORDER BY order_date)` |
| **CASE 문 사용**             | `CASE` 문으로 조건 표현식을 윈도우 함수 내 처리.                        | `MIN(CASE WHEN condition THEN column END) OVER (PARTITION BY customer_id)`; `SUM(CASE WHEN condition THEN value ELSE 0 END) OVER (PARTITION BY customer_id)` |

### 윈도우 함수 vs. GROUP BY 비교

| **항목**              | **윈도우 함수**                                                                 | **GROUP BY**                                                                 |
|-----------------------|--------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| **동작 방식**         | 모든 행 유지, 파티션 내 계산 (`PARTITION BY`).                                 | 행을 집계하여 그룹당 한 행으로 줄임.                                        |
| **사용법**            | `SELECT column, RANK() OVER (PARTITION BY customer_id ORDER BY order_date)`    | `SELECT customer_id, MIN(order_date) FROM table GROUP BY customer_id`        |
| **성능**              | 정렬로 O(n log n) 비용. 인덱스(`customer_id`, `order_date`) 활용 가능.          | 조인 시 추가 테이블 스캔 발생. 인덱스 활용 가능성 낮음.                       |
| **결과 행 수**        | 모든 행 유지.                                                                  | 그룹당 한 행 반환.                                                  |