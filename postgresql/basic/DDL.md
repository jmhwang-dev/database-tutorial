# DDL (Data Definition Language)
## CREATE
- 테이블 생성
    ```sql
    CREATE TABLE weather (
        city            varchar(80),
        temp_lo         int,           -- low temperature
        temp_hi         int,           -- high temperature
        prcp            real,          -- precipitation
        date            date
    );
    ```
    ```sql
    CREATE TABLE cities (
        name            varchar(80),
        location        point
    );
    ```
## ALTER
- 기존 존재하는 객체의 구조를 수정

## DROP
- 데이터베이스 객체를 삭제
    ```sql
    DROP TABLE tablename;
    ```

## TRUNCATE
- 테이블의 모든 데이터를 삭제