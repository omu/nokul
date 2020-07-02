---
author(s):
  - Recai Oktaş (@roktas)
---

`Nokul::Tenant::Codification`
=============================

Nokul'da kiracılar arasında ortak olarak kullanılabilecek kodifikasyon lojiğini
barındıran en üst katmandaki API.  Bu API alt seviyede `Support::Codification`
kitaplığını kullanır.  API'de `Unit`, `User`, `Student` ve `Employee`
modellerine ilişkin kodifikasyon lojiği bulunmaktadır.

`Unit`
------

*`code_generator(starting:, ending:, only: nil, except: nil, memory:)`*

Bu metodda `except` ve `only` argümanları:

- Üretilen kodu hariç tutar (`except`) veya sadece belirli bir biçimde olmasını sağlar (`only`)
- Skalar veya dizi olabilir
- Her bir öge geçerli bir düzenli ifade string'i

Birim kodları üreteci.

```ruby
generator = Nokul::Tenant::Codification::Unit.code_generator(starting: '001', ending: '999', memory: nil)
generator.run #=> '001'
generator.run #=> '002'

generator = Nokul::Tenant::Codification::Unit.code_generator(starting: '001', ending: '999', memory: nil,
                                                             except: '^0{2,}')
generator.run #=> '010'
generator.run #=> '011'
```

`User`
------

*`name_generate(first_name:, last_name:, memory:)`*

Rastgele son ekli kullanıcı adı üreteci.

```ruby
generator = Nokul::Tenant::Codification::User.name_generate(first_name: 'Mustafa Kemal', last_name: 'Atatürk', memory: nil)
generator.run #=> 'mkataturk.123' rastgele son ek
```

*`name_suggest(first_name:, last_name:, memory:)`*

Son eksiz kullanıcı adı önerileri.

```ruby
suggestions = Nokul::Tenant::Codification::User.name_suggest(first_name: 'Mustafa Kemal', last_name: 'Atatürk', memory: nil)
suggestions #=> ['mkataturk', 'mkemala', 'mustafaka', 'mkemalataturk', 'mustafakataturk', 'mustafakemala', 'mustafakemalataturk']
```

`Student`
---------

*`short_number_generator(unit_code:, year: nil, starting:)`*

Kısa biçimli öğrenci numarası üreteci.

```ruby
generator = Nokul::Tenant::Codification::Student.short_number_generator(unit_code: '203', year: '20', starting: '001')
generator.run #=> '20320001'
generator.run #=> '20320002'
```

*`long_number_generator(unit_code:, starting:)`*

Uzun biçimli öğrenci numarası üreteci.

```ruby
generator = Nokul::Tenant::Codification::Student.long_number_generator(unit_code: '203', starting: '001')
generator.run #=> '20300001'
generator.run #=> '20300002'
```

`Employee`
----------

Henüz gerçeklenmedi.

Özelleştirme
------------

Kodifikasyon lojiğini olduğu gibi kullanmak istiyorsanız
`plugins/tenant/KİRACI/app/lib/codification.rb` dosyasını aşağıdaki içerikle
oluşturmanız yeterli.

```ruby
Codification = Tenant::Codification
```

Belirli bir metodu özelleştirmek istiyorsanız özelleştireceğiniz metodun
bulunduğu modülü `extend` ederek aynı dosyada aşağıdakine benzer bir düzenleme
yapmanız gerekiyor.

```ruby
module Codification
  # Ortak lojiği olduğu gibi al
  include Tenant::Codification

  # Sadece öğrenci numarası üretecini değiştireceğiz
  module Student
    extend Tenant::Codification::Student

    module_function

    def short_number_generator(**args)
      Support::Codification.sequential_numeric_codes args[:starting], prefix: args[:year], net_length: 6, base: 10
    end
  end
end
```

Örneği basit tutmak için sanitizasyon yapılmamıştır.  Bu özelleştirmede sadece
öğrenci numarası üreteci özelleştirilmiştir.  Diğer tüm metodlar değişiklik
olmadan kullanılabilir.
