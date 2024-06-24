# DML (Data Manipulation Language)
## INSERT
- `INSERT` statement로 데이터를 삽입(populate)할 수 있다.
    ```sql
    INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');
    ```
    ```sql
    INSERT INTO weather (city, temp_lo, temp_hi, prcp, date)
        VALUES ('San Francisco', 43, 57, 0.0, '1994-11-29');
    ```
- text file로 부터 데이터를 로드할 수 있다.

    > This is usually faster because the COPY command is optimized for this application while allowing less flexibility than INSERT
    ```sql
    COPY weather FROM '/home/user/weather.txt';
    ```

## SELECT
- `SELECT` statement로 열을 지정할 수 있다.
    ```sql
    SELECT * FROM weather;
    ```
    ```sql
    SELECT city, temp_lo, temp_hi, prcp, date FROM weather;
    ```
- 사칙연산을 사용할 수 도 있다.
### `AS`
- ouput 열을 relabel 할 수 있다.
    ```sql
    SELECT city, (temp_hi+temp_lo)/2 AS temp_avg, date FROM weather;

        city      | temp_avg |    date
    ---------------+----------+------------
    San Francisco |       48 | 1994-11-27
    San Francisco |       50 | 1994-11-29
    Hayward       |       45 | 1994-11-29
    (3 rows)
    ```

### `WHERE`: `Boolean` expression을 포함하여 조건에 맞는 데이터를 반환할 수 있다.
- `AND`
- `OR`
- `NOT`
```sql
SELECT * FROM weather
    WHERE city = 'San Francisco' AND prcp > 0.0;
```

### `ORDER BY [columns]`: 정렬
```sql
SELECT * FROM weather
    ORDER BY city;
```
- 정렬할 열은 여러 개 지정할 수 있다.

    ```sql
    SELECT * FROM weather
        ORDER BY city, temp_lo;
    ```
### `DISTINCT`
- 중복 행을 제거하여 볼 수 있다.
    ```sql
    SELECT DISTINCT city
        FROM weather;
    ```

### `JOIN [table] ON [condition]`
```sql
SELECT * FROM weather JOIN cities ON city = name;
```
- `JOIN` 시, 중복 열의 이름을 지정할 수 있다.

    ```sql
    SELECT weather.city, weather.temp_lo, weather.temp_hi,
        weather.prcp, weather.date, cities.location
        FROM weather JOIN cities ON weather.city = cities.name;
    ```

### `LEFT OUTER JOIN [tabel] ON [condition]`:
- 왼쪽 테이블의 모든 행을 포함하며, 오른쪽 테이블과 일치하는 행이 있는 경우에만 결합

    ```sql
    SELECT *
        FROM weather LEFT OUTER JOIN cities ON weather.city = cities.name;
    ```
    ```sql
    SELECT w1.city, w1.temp_lo AS low, w1.temp_hi AS high,
        w2.city, w2.temp_lo AS low, w2.temp_hi AS high
        FROM weather w1 JOIN weather w2
            ON w1.temp_lo < w2.temp_lo AND w1.temp_hi > w2.temp_hi;
    ```
    ```sql
    SELECT *
        FROM weather w JOIN cities c ON w.city = c.name;
    ```

### Aggregate - 집계
```sql
SELECT max(temp_lo) FROM weather;
```
- 집계함수는 `WHERE` 절에서 사용할 수 없다.

    ```sql
    -- WRONG
    SELECT city FROM weather WHERE temp_lo = max(temp_lo);

    -- CORRECT
    SELECT city FROM weather
        WHERE temp_lo = (SELECT max(temp_lo) FROM weather);
    ```
- `GROUP BY`와 조합하면 매우 유용하다.
    ```sql
    SELECT city, count(*), max(temp_lo)
        FROM weather
        GROUP BY city;

        city      | count | max
    ---------------+-------+-----
    Hayward       |     1 |  37
    San Francisco |     1 |  46
    (2 rows)
    ```

## UPDATE
```sql
UPDATE weather
    SET temp_hi = temp_hi - 2,  temp_lo = temp_lo - 2
    WHERE date > '1994-11-28';
```
```sql
SELECT * FROM weather;

     city      | temp_lo | temp_hi | prcp |    date
---------------+---------+---------+------+------------
 San Francisco |      46 |      50 | 0.25 | 1994-11-27
 San Francisco |      41 |      55 |    0 | 1994-11-29
 Hayward       |      35 |      52 |      | 1994-11-29
(3 rows)
```

## DELETE
- 조건에 맞는 행 삭제
    ```sql
    DELETE FROM weather WHERE city = 'Hayward';
    ```
- 모든 행 삭제
    ```sql
    DELETE FROM tablename;
    ```