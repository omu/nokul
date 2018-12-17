## Rules

- `boolean` alanlar için **mutlaka** `null_constraint` eklenmelidir.

- `boolean` alanlara **mutlaka** `default` bir değer tanımlanmalıdır. Örn: `default: false` gibi.

## Boolean

Boolean bir alanın `nil` olması yönetilmesi oldukça güç bir durumdur. Örneğin:

```ruby
Student.where(active: nil).count => 50
Student.where(active: false).count => 40
Student.where(active: true).count => 60
```

Bu durumda `nil` değerini içeren kayıtların tek tek incelenerek düzeltilmesi gerekmekte.
