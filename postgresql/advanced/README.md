# VIEW
```sql
CREATE VIEW myview AS
    SELECT name, temp_lo, temp_hi, prcp, date, location
        FROM weather, cities
        WHERE city = name;

SELECT * FROM myview;
```
## 1. 데이터 보안 및 접근 제어
- 뷰는 특정 사용자 그룹이나 역할에게만 필요한 데이터를 제한적으로 노출할 수 있습니다.
- 사용자가 직접 테이블에 접근하지 않고 뷰를 통해 데이터에 접근하면 데이터 보안이 강화됩니다.

## 2. 복잡성 감소
- 복잡한 쿼리를 미리 정의된 뷰로 감싸면, 사용자는 단순한 쿼리를 실행하여 복잡한 조인이나 계산을 숨길 수 있습니다.
- 이는 쿼리 작성의 간편함과 코드의 가독성을 높입니다.

## 3. 재사용성
- 뷰는 반복적으로 필요한 데이터 집합을 정의하고 저장할 수 있습니다.
- 여러 쿼리에서 동일한 데이터 집합에 접근할 필요가 있을 때 뷰를 사용하여 재사용성을 높일 수 있습니다.

## 4. 간단한 인터페이스 제공
- 뷰를 사용하면 복잡한 데이터 모델을 단순화하고, 사용자에게 필요한 필드만 노출하여 인터페이스를 단순화할 수 있습니다.

## 5. 성능 향상
- 뷰는 쿼리 최적화를 통해 성능을 향상시킬 수 있습니다.
- 데이터베이스 시스템은 뷰 정의를 기반으로 쿼리를 최적화할 수 있으며, 필요한 경우 인덱스를 생성하여 성능을 더욱 개선할 수 있습니다.

## 6. 복잡한 계산 및 집계
- 뷰를 사용하여 복잡한 계산이나 집계 작업을 미리 정의할 수 있습니다.
- 예를 들어, 여러 테이블에서 데이터를 조인하고 특정 조건에 따라 계산된 값을 제공하는 뷰를 생성할 수 있습니다.

# Foreign Keys
- 외래키는 한 테이블의 열(또는 열들)이 다른 테이블의 기본키(primary key)를 참조하는 제약 조건(constraint)입니다.
- 이를 통해 두 테이블 간의 부모-자식 관계를 정의할 수 있습니다.-
- 부모 테이블의 기본키는 자식 테이블의 외래키에 의해 참조되며, 이를 통해 데이터 일관성과 정확성을 유지할 수 있습니다.

> - 외래키(Foreign Key)는 관계형 데이터베이스에서 중요한 개념입니다.
> - 특히 데이터베이스 설계에서 데이터 간의 관계를 정의하고 유지하는 데 사용됩니다.
> - 여러 테이블 간의 관계를 표현하며 데이터의 무결성(integrity)을 유지하는 데 중요한 역할을 합니다.

``` sql
CREATE TABLE cities (
        name     varchar(80) primary key,
        location point
);

CREATE TABLE weather (
        city      varchar(80) references cities(name),
        temp_lo   int,
        temp_hi   int,
        prcp      real,
        date      date
);
```

```sql
INSERT INTO weather VALUES ('Berkeley', 45, 53, 0.0, '1994-11-28');


ERROR:  insert or update on table "weather" violates foreign key constraint "weather_city_fkey"
DETAIL:  Key (city)=(Berkeley) is not present in table "cities".
```

# Transactions
```sql
BEGIN;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
SAVEPOINT my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Bob';
-- oops ... forget that and use Wally's account
ROLLBACK TO my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Wally';
COMMIT;
```
> Note<br>
Some client libraries issue BEGIN and COMMIT commands automatically, so that you might get the effect of transaction blocks without asking. Check the documentation for the interface you are using.