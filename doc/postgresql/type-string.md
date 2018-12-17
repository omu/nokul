## Rules

- `string`'ler için `limit: N` kullanmayın. `add_length_constraint` kullanın.

- `text` türünü kullanmayın, bunun yerine `string` türü kullanın ve `add_length_constraint` ekleyin.

- Uzunluğundan emin olmadığınız string alanları için 255 sınırı ekleyin:

  `add_length_constraint :table, :column, less_than_or_equal_to: 255` ekleyin.

- Uzunluğundan emin olduğunuz string alanları için net limitler ekleyin:

  `add_length_constraint :users, :id_number, equal_to: 11`

- 255 karakterden uzun olacağını düşündüğünüz alanlar için en fazla `65535` karakter kontrolü ekleyin:

  `add_length_constraint :committee_decisions, :description, less_than_or_equal_to: 65535`

- Boş geçilmemesi gereken alanlar için `add_presence_constraint` kullanın:

  `add_presence_constraint :countries, :name`

- Eşşiz olması gereken alanlar için `add_unique_constraint` kullanın:

  `add_unique_constraint :users, :email`

- `50`, `70` gibi herhangi bir mantığı olmayan karakter sayısı kontrolleri eklemeyin, yalnızca `255` ve `65535` kullanın.

## varchar VS varchar(n) VS char VS text

- Postgres `limit` tanımlamadığınız sürece tüm metin alanları için her bir satıra sınırsız (1 GB~) veri girebilmenize izin verir.
- Postgres'te `varchar (n)` ve `text` arasında performans ve boyut yönünden herhangi bir fark bulunmamaktadır.
- `varchar(n)` olası bir limit değişikliği durumunda tabloya LOCK atarak down-time yarattığı için limit tanımlamaları sütuna değil, `CHECK` olarak eklenmelidir.

## Referanslar

- https://www.depesz.com/2010/03/02/charx-vs-varcharx-vs-varchar-vs-text/
- https://stackoverflow.com/questions/4848964/postgresql-difference-between-text-and-varchar-character-varying
- https://dba.stackexchange.com/questions/125499/what-is-the-overhead-for-varcharn/125526#125526
- https://dba.stackexchange.com/questions/89429/would-index-lookup-be-noticeably-faster-with-char-vs-varchar-when-all-values-are/89433#89433
