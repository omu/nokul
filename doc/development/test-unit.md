---
author: M. Serhat Dundar
---

# Unit Tests

- Unit Test yazarken ilgili modülleri testinize include ederek aşağıda örneklenen test yardımcılarını kullanabilirsiniz.
- Nokul'da kullanılan stil, her satırda bir attribute'ün test edilmesidir!

--------------------------------------------------

## Associations

### has_one

```ruby
  has_one :address
  has_one :address, :identity
```

### has_many

```ruby
  has_many :addresses
  has_many :addresses, :identities
  has_many :addresses, through: :foo, dependent: :destroy
```

### belongs_to

```ruby
  belongs_to :user
  belongs_to :user, :unit,
  belongs_to :user, optional: true
```

--------------------------------------------------

## Callbacks

- Mümkün olan key değerleri `:before`, `:after` ve `:around`'tur.

```ruby
  has_initialize_callback :method_name, :key
  has_find_callback :method_name, :key
  has_touch_callback :method_name, :key
  has_validation_callback :method_name, :key
  has_save_callback :method_name, :key
  has_create_callback :method_name, :key
  has_update_callback :method_name, :key
  has_destroy_callback :method_name, :key
  has_commit_callback :method_name, :key
  has_rollback_callback :method_name, :key
```

--------------------------------------------------

## Validations

### Presence

```ruby
validates_presence_of :name
validates_presence_of :name, :code, :year
```

### Presence of Nested Model

```ruby
validates_presence_of_nested_model :lecturers
validates_presence_of_nested_model :lecturers, ids: 'employee_ids'
```

### Uniqueness

```ruby
validates_uniqueness_of :name
validates_uniqueness_of :name, :code, :year
```

### Length

```ruby
validates_length_of :name # default: { maximum: 255 }
validates_length_of :id_number, is: 11
validates_length_of :description, maximum: 65535
validates_length_of :first_name, minimum: 2
```

### Numericality

```ruby
validates_numericality_of :year
```

### Numerical Range

```ruby
validates_numerical_range :yoksis_code, greater_than: 4000
validates_numerical_range :yoksis_code, greater_than_or_equal_to: 1000
validates_numerical_range :yoksis_code, less_than: 500
validates_numerical_range :yoksis_code, less_than_or_equal_to: 2000

```

--------------------------------------------------

## Enums

```ruby
has_enum :term, fall: 0, spring: 1, summer: 2
```
