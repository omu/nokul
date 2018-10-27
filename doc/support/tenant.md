`Tenant`
========

Kiracı özgünlüklerini barındıran `/tenant` dizinini yöneten ve genel olarak
kiracılarla ilgili yapılan tüm işlemleri destekleyen modül.

Kovansiyon
----------

Uygulama kökünde yeni bir dizin olarak kiracı dizini Rails konvansiyonlarına
yaptığımız bir ekleme.  Bu yeni konvansiyonu `/lib/support/tenant/convention.rb`
ile kodifiye ediyoruz.  Konvansiyon şu metodları barındırıyor:

- `Tenant.active`: `RAILS_TENANT` ortam değişkenine başvurarak etkin kiracıyı
  döner.

  ```ruby
  Tenant.active #=> "omu"
  ```

- `Tenant.root`: Kiracı kök dizinini `Pathname` nesnesi olarak döner.

  ```ruby
  Tenant.root.to_s #=> "«Rails kök dizini»/tenant"
  ```

- `Tenant.path`: Verilen göreceli yolu etkin kiracı dizininde çözer.

  ```ruby
  Tenant.path('app/foo') #=> "«Rails kök dizini»/tenant/omu/app/foo"
  ```

- `Tenant.config_file`: Etkin kiracıya ait ana yapılandırma dosyasını döner.

  ```ruby
  Tenant.config_file #=> "«Rails kök dizini»/tenant/omu/config/config.yml"
  ```

- `Tenant.configuration`: `Rails.configuration`'a benzer şekilde etkin kiracıya
  ait yapılandırmanın etkin Rails ortamına karşı düşen bölümünü `OpenStruct`
  nesnesi olarak döner.

- `Tenant.load_rules`: Tüm kiracılar için ortak olan kurallardan (`rules`)
  başlayarak etkin kiracıya ait tüm kuralları yükler.

- `Tenant::Path`: Ortak ve etkin kiracı dizinlerinde konvansiyonla eklenen
  `app`, `config`, `db` ve `test` alt dizin yollarını çözer.  Ortak kiracı
  dizinleri `common_` ile ön eklidir.

  ```ruby
  Tenant::Path.app           #=> "«Rails kök dizini»/tenant/omu/app"
  Tenant::Path.config        #=> "«Rails kök dizini»/tenant/omu/config"
  Tenant::Path.db            #=> "«Rails kök dizini»/tenant/omu/db"
  Tenant::Path.test          #=> "«Rails kök dizini»/tenant/omu/test"

  Tenant::Path.common_app    #=> "«Rails kök dizini»/tenant/common/app"
  Tenant::Path.common_config #=> "«Rails kök dizini»/tenant/common/config"
  Tenant::Path.common_db     #=> "«Rails kök dizini»/tenant/common/db"
  Tenant::Path.common_test   #=> "«Rails kök dizini»/tenant/common/test"
  ```
