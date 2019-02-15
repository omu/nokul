---
author: M. Serhat Dundar
---

## Rules

- Integer'lar üzerinde `limit: N` kullanmayın.

- Çoğunlukla `integer` bir değerin `nil` dönmesi beklenmez, `0` dönmesi beklenir. Geçerli bir sebebiniz olmadıkça `null_constraint` ekleyin:

  ```ruby
  add_null_constraint :users, :articles_count
  ```

- `default` bir değer (çoğunlukla 0) tanımlamak, çoğu zaman mantıklı olacaktır. `default` bir değer ile birlikte `null_constraint` ekleyin:

  ```ruby
  t.integer :articles_count, default: 0
  add_null_constraint :users, :articles_count
  ```

- Negatif değerleri kabul etmiyorsanız `numericality_constraint` ekleyin:

  ```ruby
  add_numericality_constraint :users, :articles_count,
                                    greater_than_or_equal_to: 0
  ```

- Olası değerleri belirli olan integer değerler için üst ve alt limitleri belirleyin:

  ```ruby
  add_numericality_constraint :articles, :month,
                                         greater_than_or_equal_to: 1,
                                         less_than_or_equal_to: 12
  add_numericality_constraint :articles, :year,
                                         greater_than_or_equal_to: 1950,
                                         less_than_or_equal_to: 2050
  ```

## Referanslar

- https://gist.github.com/icyleaf/9089250
- https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html
- https://github.com/rails/rails/blob/master/activerecord/lib/active_record/connection_adapters/postgresql_adapter.rb
- https://stackoverflow.com/questions/38053596/benchmark-bigint-vs-int-on-postgresql
- https://stackoverflow.com/questions/2966524/calculating-and-saving-space-in-postgresql/7431468#7431468
