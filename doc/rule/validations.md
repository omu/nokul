---
author: M. Serhat Dundar
---

# Validations

## Rule

### String

- `string` alanlar için `length: { maximum: 255 }` kullanın.

- Daha uzun `string` alanlar için `length: { maximum: 65_535 }` kullanın.

- `length` validasyonu `presence` kontrolü yapmaz. Yani `nil` bir değer `length` validasyonunu geçebilir. Dolayısıyla varlık kontrolü yapmak istiyorsanız `presence: true` kullanın. İstemiyorsanız boş bırakın - `allow_nil` veya `allow_blank` kullanmanıza gerek yok.

- `allow_blank` veritabanında boş string'lerin oluşmasına sebep olduğu için genel olarak hiç kullanmayın.

### Integer || Decimal || Float

- `numericality` validasyonu varsayılan olarak attribute'e `presence` kontrolü yapar. Dolayısıyla `numericality` kullandığınız yerde `presence` kullanmayın.

- Nümerik alanların negatif bir sayı olmasını istemiyorsanız `greater_than_or_equal_to: 0` gibi validasyonlar kullanın.

- Nümerik alanın çok büyük sayılar olmasını istemiyorsanız `less_than: N` gibi validasyonlar kullanın.

- Değer aralığı nispeten daha net olan ay, yıl gibi alanlar için daha küçük aralıklar tanımlayın:

  `validates :year, numericality: { greater_than: 1950, less_than: 2050 }`

- Nümerik alanın tam sayı olmasını istiyorsanız `only_integer: true` ekleyin.

- `numericality` validasyonu kullandığınız bir alanın `nil` olabilmesini istiyorsanız `allow_nil: true` kullanın.

### Boolean

- `boolean` alanlar için `inclusion: { in: [true, false] }` validasyonu ekleyin.

- `boolean` alanlarda `inclusion` kullandığınız için `presence` validasyona gerek yoktur, eklemeyin.

### Enum

- Enum olarak tasarladığınız `integer` alanlara `inclusion` validasyonu ekleyin.

- `inclusion` validasyonuna değer kümesi olarak tanımladığınız enum'un anahtarlarını verin:
  ```
  enum marital_status: { single: 1, married: 2, divorced: 3, unknown: 4 }
  validates :marital_status, inclusion: { in: marital_statuses.keys }
  ```

- `inclusion` validasyonu `presence` kontrolü yapmaktadır. Eğer alanın `nil` olmasını istemiyorsanız `presence` eklemenize gerek yok. Eğer alan `nil`'de olabilsin istiyorsanız `allow_nil: true` ekleyin.

- Yazdığınız enum yalnızca 2 değerden oluşuyorsa onu `boolean`'a çevirmeyi düşünün.


## Style

Her bir `attribute` için ayrı bir validates satırı ve aynı satırda validasyonlar. Eğer satır 120 satırı geçiyorsa, sığmayan validasyon hizalı şekilde alt satıra.

Öncelik sırası:

1. presence || allow_nil || allow_blank
1. uniqueness
1. numericality || length
1. diğerleri

**DOĞRU:**

```ruby
validates :type, presence: true
validates :district, presence: true
validates :unit_status, presence: true
validates :unit_instruction_type, presence: true
validates :yoksis_id, uniqueness: true, numericality: { only_integer: true }
validates :name, presence: true, uniqueness: { scope: %i[ancestry unit_status_id] }
validates :duration, numericality: { only_integer: true }, allow_nil: true
```

**YANLIŞ: [compact]**

```ruby
validates :email, :id_number, :date_of_birth
          presence: true, uniqueness: true
validates :id_number,
          numericality: { only_integer: true }
```

**YANLIŞ: [compact + her bir validasyon ayrı satırda]**

```ruby
validates :email, :id_number, :date_of_birth
          presence: true,
          uniqueness: true
validates :id_number,
          numericality: { only_integer: true }
```

**YANLIŞ: [her bir validasyon türü için ayrı bir validates satırı, validasyonlar ayrı satırda]**

```ruby
validates :email, :id_number, :date_of_birth
          presence: true
validates :email, :id_number, :date_of_birth
          uniqueness: true
validates :id_number,
          numericality: { only_integer: true }
```

**YANLIŞ: [her bir attribute için ayrı bir validates satırı, validasyonlar ayrı satırda]**

```ruby
validates :email,
          presence: true, uniqueness: true
validates :id_number,
          presence: true, uniqueness: true, numericality: { only_integer: true }
validates :date_of_birth,
          presence: true, uniqueness: true
```

**YANLIŞ: [her bir attribute için ayrı bir validates satırı, her bir validasyon ayrı satırda]**

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

**YANLIŞ: [her bir attribute ve validasyon türü için ayrı bir validates satırı]**

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
