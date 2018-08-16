# Validations

Her bir `attribute` için ayrı bir validates satırı ve aynı satırda validasyonlar. Eğer satır 120 satırı geçiyorsa, sığmayan validasyon hizalı şekilde alt satıra.

Öncelik sırası:

1. presence,
1. uniqueness,
1. numericality || length
1. diğerleri

**Good:**

```ruby
validates :type, presence: true
validates :district, presence: true
validates :unit_status, presence: true
validates :unit_instruction_type, presence: true
validates :yoksis_id, presence: true, uniqueness: true, numericality: { only_integer: true }
validates :name, presence: true, uniqueness: { scope: %i[ancestry unit_status_id] }
validates :duration, numericality: { only_integer: true }, allow_blank: true
```

**Bad: [compact]**

```ruby
validates :email, :id_number, :date_of_birth
          presence: true, uniqueness: true
validates :id_number,
          numericality: { only_integer: true }
```

**Bad: [compact + her bir validasyon ayrı satırda]**

```ruby
validates :email, :id_number, :date_of_birth
          presence: true,
          uniqueness: true
validates :id_number,
          numericality: { only_integer: true }
```

**Bad: [her bir validasyon türü için ayrı bir validates satırı, validasyonlar ayrı satırda]**

```ruby
validates :email, :id_number, :date_of_birth
          presence: true
validates :email, :id_number, :date_of_birth
          uniqueness: true
validates :id_number,
          numericality: { only_integer: true }
```

**Bad: [her bir attribute için ayrı bir validates satırı, validasyonlar ayrı satırda]**

```ruby
validates :email,
          presence: true, uniqueness: true
validates :id_number,
          presence: true, uniqueness: true, numericality: { only_integer: true }
validates :date_of_birth,
          presence: true, uniqueness: true
```

**Bad: [her bir attribute için ayrı bir validates satırı, her bir validasyon ayrı satırda]**

```ruby
validates :email,
          presence: true,
          uniqueness: true
validates :id_number,
          presence: true,
          uniqueness: true,
          numericality: { only_integer: true }
validates :date_of_birth,
          presence: true,
          uniqueness: true
```

**Bad: [her bir attribute ve validasyon türü için ayrı bir validates satırı]**

```ruby
validates :email, presence: true
validates :email, uniqueness: true
validates :id_number, presence: true
validates :id_number, uniqueness: true
validates :id_number, numericality: { only_integer: true }
validates :date_of_birth, presence: true
validates :date_of_birth, uniqueness: true
validates :email, uniqueness: true
```