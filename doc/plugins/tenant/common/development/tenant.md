---
author(s):
  - Recai Oktaş (@roktas)
---

`Nokul::Tenant`
===============

Tüm kiracılarda ortak olarak kullanılan lojiği barındıran modül.

İlkleme
-------

Aktif kiracı aşağıdaki olay sırasıyla yüklenir.  Örneklendirme `Nokul::Tenant::OMU` kiracısı üzerinden yapılmıştır.

- `NOKUL_TENANT` ortam değişkeni ayarlanır.  Geçerli değer `plugins/tenant` dizini altındaki bir dizin adı (`common`
  dışında) olmalıdır.  Örneğin `NOKUL_TENANT=omu` ise `plugins/tenant/omu` dizini hedef alınmıştır.

- `config/application` yapılandırmasında `plugins/tenant/common/lib/nokul/tenant.rb` dosyasında tanımlı
  `Nokul::Tenant.load` çağrılır.

- `Nokul::Tenant.load` Tenant adını `plugins/tenant` altındaki ilgili Gem ile eşleştirerek Gem'i `require` ile yükler;
  örneğin `plugins/tenant/omu`.

- Yüklenen Gem'de `lib/nokul/tenant/omu/engine.rb` dosyasında tanımlı `Nokul::Tenant::OMU < Rails::Engine` sınıfı
  `plugins/tenant/common/lib/nokul/tenant/engine.rb` dosyasında tanımlı `Nokul::Tenant::Engine` modülünü katıştırır.

  ```ruby
  class Nokul::Tenant::KİRACI < Rails::Engine
    include Nokul::Tenant::Engine

    ...
  end
  ```

- `Nokul::Tenant::Engine` bir `ActiveSupport::Concern` modülüdür.  Modülde tanımlı `included` hook ile
  `plugins/tenant/common/lib/nokul/tenant.rb` dosyasındaki `Nokul::Tenant.initialize` metodu çağrılarak, metoda aktif
  Tenant sınıf adı geçirilir.

  ```ruby
  Nokul::Tenant.initialize(Nokul::Tenant::OMU)
  ```

- `Nokul::Tenant.initialize` kendisine geçirilen aktif Tenant sınıfı bilgisini kullanarak `Nokul::Tenant.engine`
  atamasını yapar.

  ```ruby
  Nokul::Tenant.engine = Nokul::Tenant::OMU.instance
  ```

- Artık aktif Tenant atandığından `plugins/tenant/omu/config/tenant.yml` dosyasındaki ana yapılandırma yüklenebilir.

  ```ruby
  Nokul::Tenant.configuration = Nokul::Tenant.engine.deep_config_for :tenant
  ```

API
---

Tüm Nokul::Tenant API metodlarını `plugins/tenant/common/lib/nokul/tenant/api.rb` dosyasında bulabilirsiniz.

- `Nokul::Tenant.name`:  Aktif Tenant adını döner.

  Örnek:

  ```ruby
  Nokul::Tenant.name #=> 'omu'
  ```

- `Nokul::Tenant.engine`: Aktif Tenant nesnesini döner.

  `Rails::Engine` sınıfından miras alan bu nesne `Ruby.application` ana uygulama nesnesiyle benzer bir işleve sahiptir.
  `Rails::Engine` sınıfındaki bazı metodları çalıştırmak için nadir durumlarda kullanılır.  Çoğu durumda bu nesneyi
  kullanmak yerine aşağıdaki sarmalayıcı metodları kullanmak yeterlidir.

- `Nokul::Tenant.configuration`: Aktif Tenant yapılandırması.

  Örnek:

  ```ruby
  Nokul::Tenant.configuration.name #=> 'Ondokuz Mayıs Üniversitesi'
  ```

- `Nokul::Tenant.root`: Aktif Tenant kök dizinini döner.  `Rails.root` ile
  benzer işlevde kullanılır.

  ```ruby
  Nokul::Tenant.root #=> '/rails/root/plugins/tenant/omu'
  ```

- `Nokul::Tenant.deep_config_for(name)`: Aktif Tenant için verilen `name` yapılandırmasının ilgili ortamda etkin
  bölümünü içi içe `OpenStruct` nesnesi halinde döner.

  Örnek:

  ```sh
  cd /rails/root/plugins/tenant/omu
  ```

  ```sh
  $ cat config/foo.yml
  production:
    bar:
      baz: ok
  ```

  ```ruby
  Rails.env.production? #=> true
  foo_config = Nokul::Tenant.deep_config_for(:foo)
  foo_config.bar.baz #=> 'ok'
  ```

- `Nokul::Tenant.load(fallback: DEFAULT_TENANT)`: `NOKUL_TENANT` ortam değişkenine bakarak aktif Tenantı yükler.

  Örnek:

  ```ruby
  Nokul::Tenant.load
  ```

- `Nokul::Tenant.units(predication = nil)`: Birleştirilmiş birimler kolleksiyonunu (`src/all` kaynağından yükleyerek)
  döner.  İsteğe bağlı olarak verilen `predication` argümanıyla dönülen kolleksiyonda filtreleme yapar.

  Örnek:

  ```ruby
  Nokul::Tenant.units                 #=> Tüm birleştirilmiş birimler
  Nokul::Tenant.units :administrative #=> Sadece idari birimler
  Nokul::Tenant.units :academic       #=> Sadece akademik birimler
  ```

  Kullanılabilecek `predication` seçenekleri için `plugins/tenant/common/lib/nokul/tenant/units/concerns/predicable.rb`
  dosyasına başvurun (method adlarındaki `?` karakterini kaldırmayı unutmayın).

- `Nokul::Tenant.unit_types(category = nil)`: Birleştirilmiş birimler bağlamında tüm tekil birim tiplerini döner.
  İsteğe bağlı olarak verilen `category` argümanıyla sadece ilgili kategorideki birim tiplerini döner.  `category`
  argümanı `adminisitrative` ve `academic` değerlerini alabilir.

  Örnek:

  ```ruby
  Nokul::Tenant.unit_types                 #=> Tüm birim tipleri
  Nokul::Tenant.unit_types :administrative #=> Sadece idari birim tipleri
  Nokul::Tenant.unit_types :academic       #=> Sadece akademik birim tipleri
  ```
