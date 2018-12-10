## TL;DR

- `limit: N` yerine `add_length_constraint` kullanın.
- `text` türü kullanmayın, bunun yerine `string` türü kullanın ve limitleri ihtiyacınıza göre ayarlayın.

## varchar VS varchar(n) VS char VS text

- Postgres `limit` tanımlamadığınız sürece tüm metin alanları için her bir satıra sınırsız (1 GB~) veri girebilmenize izin verir.
- Postgres'te `string (varchar)` ve `text` arasında herhangi bir fark bulunmamaktadır.
- `varchar(n)` olası bir limit değişikliği durumunda tabloya LOCK atarak down-time yarattığı için limit tanımlamaları sütuna değil, `CHECK` olarak eklenmelidir.

### Must See

- https://www.depesz.com/2010/03/02/charx-vs-varcharx-vs-varchar-vs-text/
- https://stackoverflow.com/questions/4848964/postgresql-difference-between-text-and-varchar-character-varying
- https://dba.stackexchange.com/questions/125499/what-is-the-overhead-for-varcharn/125526#125526
- https://dba.stackexchange.com/questions/89429/would-index-lookup-be-noticeably-faster-with-char-vs-varchar-when-all-values-are/89433#89433
