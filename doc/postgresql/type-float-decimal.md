## Rules

- `float`: Kesinliğin çok önemli olmadığı, yalnızca virgülden sonraki 3-5 basamak ile ilgilendiğiniz, ve bu rakamlar ile yoğun aritmedik işlem yapacağınız durumlarda kullanın.
- `decimal`: Kesinliğin çok önemli olduğu (örneğin ödeme işlemleri), hatta performanstan da önemli olduğu durumlarda kullanın.

- Hangi türü kullanırsanız kullanın, `default` bir değer tanımladıysanız `null_constraint` ekleyin:

```ruby
t.decimal :min_credit, precision: 5, scale: 2, default: 0
add_null_constraint :course_types, :min_credit
```

- Hangi türü kullanırsanız kullanın, negatif değerleri kabul etmiyorsanız `numericality_constraint` ekleyin:

```ruby
add_numericality_constraint :course_types, :min_credit,
                                           greater_than_or_equal_to: 0
```

- Çoğunlukla `float` veya `decimal` bir değerin `nil` dönmesi beklenmez, `0` dönmesi beklenir. Geçerli bir sebebiniz olmadıkça `null_constraint` ekleyin:

```ruby
add_null_constraint :course_types, :min_credit
```

## Float & Decimal

PostgreSQL'de float ve decimal türleri arasında çeşitli farklar bulunmakta. Öncelikle Rails'in hangi durumda ne ürettiğine bakalım:

```ruby
t.float :incentive_point
```

```
 Column          | Type              | Nullable |
-----------------+------------------------------+
 incentive_point | double precision  |          |
```

```ruby
t.decimal :min_credit, precision: 5, scale: 2
```

```
 Column          | Type             | Nullable |
-----------------+-----------------------------+
 credit          | numeric(5,2)     |          |
```

Yani Rails'te:
- `float` -> `double_precision`
- `decimal` -> `numeric(x, y)` & `decimal(x, y)`

PostgreSQL veri türüne karşılık gelmekte. Kavramlar karışmadan önce PostgreSQL'de bu veri türlerinin farklarına bakacak olursak:

```
  name             | size     | description | range                                                                       | in-rails |
-------------------+----------+-------------+-----------------------------------------------------------------------------+----------+
| decimal (p, s)   | variable | exact       | p(total digits), s(digits after decimal point), max(p)=131072, max(s)=16383 | decimal  |
| numeric (p, s)   | variable | exact       | p(total digits), s(digits after decimal point), max(p)=131072, max(s)=16383 | decimal  |
| double-precision | 8-bytes  | inexact     | 15 significant digits, unlimited size                                       | float    |
```

Buradan varılacak sonuçlar:

- PostgreSQL'de `decimal` ve `numeric` türleri birbiriyle aynı.
- PostgreSQL'de decimal ve numeric `exact` iken, float (double-precision) türü `inexact`.
- `numeric` türü çeşitli sınırlara sahip iken `double-precision` türü sonsuz büyüklükte olabiliyor.

## Exact?

`exact` özelliğinde bir veri, database'de insert edildiği şekliyle tutulurken, `inexact` özelliğindeki veriler insert edildikleri şekilde tutulmaz, bir dönüşüme uğrarlar. Dolayısıyla parasal işlemler gibi yuvarlama hatalarına yer olmayan durumlarda `numeric` tercih edilmelidir.

- Q: Madem öyle `float` türünü nerede kullanabiliriz? Kim girdiği değerin tutarsız ve girdiğinden farklı bir değer olmasını ister? Hangi veri buna örnek olabilir?

1. `float`'ın kullanışlı olduğu durumlardan biri büyük veriler. Örneğin 10^20 gibi bir rakamı `numeric` olarak tutamazken, `float` olarak tutabiliyoruz.
1. `float` türü, `decimal`'a göre çok hızlı çalışmakta. Küsuratlı sayılar üzerinde yoğun çarpma, bölme, karekök alma ve benzeri işlemler gerçekleştiriyorsak, `numeric` türü CPU spike'larına yol açabiliyor, `float` bu dezavantajı ortadan kaldırıyor - ancak `exact` değil.

### Referanslar

- http://forums.devshed.com/postgresql-help-21/numeric-vs-float-607281.html
- https://stackoverflow.com/a/20887107/818033
- https://www.linuxtopia.org/online_books/database_guides/Practical_PostgreSQL_database/PostgreSQL_x2632_004.htm
- https://stackoverflow.com/a/8523253/818033
