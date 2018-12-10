## TL;DR

- `foreign_key` türündeki sütunlar için `null: false` kullanın.
- Diğer tüm türler için `change_column_null` (veya `null: false`) yerine `add_presence_constraint` kullanın.

## Not Null Constraint vs. Not Null Check

PostgreSQL'de `NOT NULL` durumu hem `CONSTRAINT` olarak, hem de `CHECK` olarak tanımlanabiliyor. `CONSTRAINT` ile `CHECK` arasında bazı farklar bulunmakta.

- Rails'in `change_column_null` metodu sütun üzerinde `CONSTRAINT` tanımlaması yaparken,
- [rein](https://github.com/nullobject/rein)'in bir methodu olan`add_presence_constraint` tabloya `CHECK` tanımlaması yapmakta.

### change_column_nil

- Rails'in `change_column_nil` metodu ilgili sütuna `not null` `CONSTRAINT` ekler:

```ruby
  change_column_null :cities, :country_id, false
```

```
                                       Table "public.cities"
    Column    |          Type          | Collation | Nullable |              Default
--------------+------------------------+-----------+----------+------------------------------------
 id           | bigint                 |           | not null | nextval('cities_id_seq'::regclass)
 name         | character varying(255) |           | not null | 
 country_id   | bigint                 |           | not null | 
Indexes:
    "cities_pkey" PRIMARY KEY, btree (id)
    "cities_name_unique" UNIQUE CONSTRAINT, btree (name) DEFERRABLE
    "index_cities_on_country_id" btree (country_id)
```

### add_presence_constraint

- `add_presence_constraint` metodu tabloya `not_null` `CHECK` ekler:

```ruby
  add_presence_constraint :cities, :country_id
```

```
                                       Table "public.cities"
    Column    |          Type          | Collation | Nullable |              Default
--------------+------------------------+-----------+----------+------------------------------------
 id           | bigint                 |           | not null | nextval('cities_id_seq'::regclass)
 name         | character varying(255) |           | not null | 
 country_id   | bigint                 |           |          | 
Indexes:
    "cities_pkey" PRIMARY KEY, btree (id)
    "cities_name_unique" UNIQUE CONSTRAINT, btree (name) DEFERRABLE
    "index_cities_on_country_id" btree (country_id)
Check constraints:
    "cities_country_id_null" CHECK (country_id IS NOT NULL)
```

[PostgreSQL dokümanlanında](https://www.postgresql.org/docs/current/ddl-constraints.html#id-1.5.4.5.6) `NOT NULL CHECK` ve `NOT NULL CONSTRAINT`'in fonksiyonel olarak aynı işi yaptığı, ancak `NOT NULL CONSTRAINT`'in daha verimli çalıştığı belirtiliyor:

> A not-null constraint is always written as a column constraint. A not-null constraint is functionally equivalent to creating a check constraint CHECK (column_name IS NOT NULL), but in PostgreSQL creating an explicit not-null constraint is more efficient.

Her ne kadar PostgreSQL dokümanı aradaki farkı istatistiki olarak tanımlamıyor. Ancak benchmark gerçekleştirmiş bir [Stackoverflow kullanıcısına](https://dba.stackexchange.com/a/158644) göre ikisi arasında istatistiki olarak anlamlı olmayan %0.5'lik bir fark bulunmakta.

## Neden `CONSTRAINT` değil de `CHECK`?

Resmi Postgres dokümanına göre `CONSTRAINT` daha hızlı çalışmaktayken (ne kadar fark olduğu belirtilmese de) `rein` neden `NOT NULL` şartını `CONSTRAINT` değil de `CHECK` olarak ekliyor? Temelde iki sebebi var:

1) `CHECK`'leri revert etmek daha maliyetsiz çünkü bunlar daha kolay revert edilebiliyor veya değiştirilebiliyor, ancak `CONSTRAINT` revert edilirken tüm sütunun tekrar yazılması gerekiyor.
2) `CONSTRAINT` üzerinde yapılan değişiklikler sütunun tekrar yazılmasını gerektirdiğinden tabloya `AccessExclusiveLock` atılıyor, yani tablo okumaya kapatılıyor. `CHECK` ise `AccessExclusiveLock` atmadığından daha düşük bir down-time sağlıyor.

## Kaynaklar

- https://www.postgresql.org/docs/current/ddl-constraints.html#id-1.5.4.5.6
- https://dba.stackexchange.com/a/158644
