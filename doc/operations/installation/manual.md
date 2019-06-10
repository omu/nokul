---
author(s):
  - M. Serhat Dundar (@msdundar)
  - Hüseyin Tekinaslan (@huseyin)
---

Nokul Kurulumu
==============

Gereksinimler
-------------

- [PostgreSQL (>=11.x)](https://www.postgresql.org/download/)
- [NodeJS (>=10.x)](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
- [Yarn](https://yarnpkg.com/lang/en/docs/install/#debian-stable)
- [Redis](https://packages.debian.org/search?keywords=redis)
- [libvips](https://github.com/jcupitt/libvips/wiki/Build-for-Ubuntu)
- [wkhtmltopdf](https://github.com/mileszs/wicked_pdf#installation)

Kurulum
-------

- `development` ve `test` ortamları için ayrı PostgresQL kullanıcıları oluştur. Politikalarımıza göre kullanıcı adı,
  uygulama adı ile aynı olmalıdır (örneğin; `nokul`).

  ```bash
  sudo -u postgres psql <<-EOF
          CREATE USER nokul WITH ENCRYPTED PASSWORD 'nokul';
          ALTER ROLE nokul LOGIN CREATEDB SUPERUSER;
  EOF
  ```

  3rd-party servislere erişebilmek için `credentials.yml.enc` dosyasında korunan bilgilere ihtiyaç duyulmaktadır. Bu
  bilgileri elde etmek için `master.key` dosyasının bir kopyasını `config` dizini altına indirmeli veya
  `RAILS_MASTER_KEY` ortam değişkenini tanımlamalısınız. Eğer yeni bir girdi ekleyecek veya varolan bir girdiyi
  düzenleyecekseniz aşağıdaki komutu çalıştırın.

  ```ruby
  bin/rails credentials:edit
  ```

- GEM bağımlılıklarını kur:

  ```bash
  bundle
  ```

- JavaScript bağımlılıklarını kur:

  ```bash
  yarn install
  ```

- Veritabanını oluştur, tabloları "migrate" et ve "seed" verilerini doldur:

  ```bash
  rake db:create
  rake db:migrate
  rake db:seed
  ```

- Veritabanını yeniden ayarlamak için (drop, reload and reseed the database) için aşağıdaki komutu kullanın:

  ```bash
  rake db:reset
  ```

Dokku'da PostgreSQL Dump Restore Etme
-------------------------------------

```bash
pg_restore -h localhost -p 5432 -U nokul -d nokul_development -v "some_dump.backup"
```
