## TL;DR

- `foreign_key` türündeki sütunlar için, eğer arada `optional: true` bir ilişki yoksa `null: false` kullanın.

- Integer, boolean ve float türleri için `null: false` kullanmayın, `add_null_constraint` kullanın.

- String türü için `null: false` kullanmayın, `add_presence_constraint` kullanın.

## Not Null Constraint vs. Not Null Check

PostgreSQL'de `NOT NULL` durumu hem `CONSTRAINT` olarak, hem de `CHECK` olarak tanımlanabiliyor. `CONSTRAINT` ile `CHECK` arasında bazı farklar bulunmakta.

- `change_column_null` (veya `null: false`) metodu sütun üzerinde `CONSTRAINT` tanımlaması yaparken,
- `add_presence_constraint` tabloya `CHECK` tanımlaması yapar.

### change_column_null (null: false)

- Rails'in `change_column_null` metodu ilgili sütuna `not null` `CONSTRAINT` ekler:

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

### add_null_constraint

- `add_null_constraint` metodu tabloya `not_null` `CHECK` ekler:

```ruby
  add_null_constraint :cities, :country_id
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

PostgreSQL dokümanı aradaki farkı istatistiki olarak tanımlamıyor. Ancak benchmark gerçekleştirmiş bir [Stackoverflow kullanıcısına](https://dba.stackexchange.com/a/158644) göre ikisi arasında istatistiki olarak anlamlı olmayan %0.5'lik bir fark bulunmakta.

### add_presence_constraint

`add_presence_constraint` string türündeki verilerin varlığını kontrol etmek için kullanılır. `add_null_constraint`'ten farklı olarak boş string'lerin sütuna yazılmasına engel olur. Yani:

```
User.create(email: ' ')
```

`null_constraint` kontrolünen geçmekteyken, `presence_constraint` kontrolünden geçemez.

## Neden `CONSTRAINT` değil de `CHECK`?

Resmi Postgres dokümanına göre `CONSTRAINT` daha hızlı çalışmaktayken (ne kadar fark olduğu belirtilmese de) `rein` neden `NOT NULL` şartını `CONSTRAINT` değil de `CHECK` olarak ekliyor? Temelde iki sebebi var:

1. `CHECK`'leri revert etmek daha maliyetsiz, ancak `CONSTRAINT` revert edilirken tüm sütunun tekrar yazılması gerekiyor.
1. `CONSTRAINT` üzerinde yapılan değişiklikler sütunun tekrar yazılmasını gerektirdiğinden tabloya `AccessExclusiveLock` atılıyor, yani tablo okumaya kapatılıyor. `CHECK` ise `AccessExclusiveLock` atmadığından daha düşük bir down-time sağlıyor.

## Kaynaklar

- https://www.postgresql.org/docs/current/ddl-constraints.html#id-1.5.4.5.6
- https://dba.stackexchange.com/a/158644
