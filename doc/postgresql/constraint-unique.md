## Rules

- Sadece gerçekten `unique` olduğundan emin olduğunuz alanlara unique constraint ekleyin. Örneğin şehir/ilçe isimleri unique değildir.

- `code` ve `identifier` gibi nesneleri birbirlerinden ayırt etmek için kullandığımız alanlar `unique_constraint`'e iyi bir aday olabilirler.

## Unique Constraint

`unique_constraint`, diğer constraint'lerden farklı olarak bir `index` oluşturarak çalışır. Örneğin:

```
users_email_unique
users_id_number_unique
```

gibi. Eğer bir unique constraint'in, ilgili transaction'ın en son kontrolü olarak çalışmasını istiyorsanız defer edebilirsiniz:

```
add_unique_constraint :books, :isbn, deferred: true
```
