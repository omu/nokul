---
author(s):
  - M. Serhat Dundar (@msdundar)
---

Unit Test
=========

- Unit Test yazarken ilgili modülleri testinize `extend` ederek aşağıda örneklenen test yardımcılarını
  kullanabilirsiniz.
- Nokul'da kullanılan stil, her satırda bir attribute'ün test edilmesidir!

Associations
------------

- Support::Minitest::AssociationHelper

### `has_one`

```ruby
  has_one :address
  has_one :address, :identity
```

### `has_many`

```ruby
  has_many :addresses
  has_many :addresses, :identities
  has_many :addresses, through: :foo, dependent: :destroy
```

### `belongs_to`

```ruby
  belongs_to :user
  belongs_to :user, :unit
  belongs_to :user, optional: true
```

### `accepts_nested_attributes_for`

```ruby
  accepts_nested_attributes_for :units, allow_destroy: true
```

Callbacks
---------

- Support::Minitest::CallbackHelper

```ruby
  after_commit :method_name
  after_create :method_name
  after_destroy :method_name
  after_find :method_name
  after_initialize :method_name
  after_rollback :method_name
  after_save :method_name
  after_touch :method_name
  after_update :method_name
  after_validation :method_name
  around_create :method_name
  around_destroy :method_name
  around_save :method_name
  around_update :method_name
  before_create :method_name
  before_destroy :method_name
  before_save :method_name
  before_update :method_name
  before_validation :method_name
```

Validations
-----------

- Support::Minitest::ValidationHelper

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

### Enums

- Support::Minitest::EnumerationHelper

```ruby
enum term: { fall: 0, spring: 1, summer: 2 }
```

#### Example

```ruby
class AcademicTermTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  has_many :calendars, dependent: :nullify
  has_many :registration_documents, dependent: :nullify

  # validations: presence
  validates_presence_of :active
  validates_presence_of :end_of_term
  validates_presence_of :start_of_term
  validates_presence_of :term
  validates_presence_of :year

  # validations: uniqueness
  validates_uniqueness_of :year

  # validations: length
  validates_length_of :year

  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }

  # callbacks
  after_save :deactivate_academic_terms
end
```
