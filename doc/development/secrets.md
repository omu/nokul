---
author(s):
  - M. Serhat Dundar (@msdundar)
---

Secrets
=======

Setup
-----

- Uygulamayı ayağa kaldırabilmek için `RAILS_MASTER_KEY` ve `TENANT_MASTER_KEY` ortam değişkenlerini sisteminize
  tanımlamanız gerekir. `bashrc`, `zshrc`, `bash_profile` vb. dosyanıza ortam değişenlerini ekleyin:

  ```bash
  export RAILS_MASTER_KEY=XXX
  export TENANT_MASTER_KEY=XXX
  ```

Uygulama Sırları
----------------

- Uygulama sırlarını görüntüle:

  ```bash
  rails credentials:show
  ```

- Uygulama sırlarını düzenle:

  ```bash
  rails credentials:edit
  ```

- Uygulama sırlarını uygulama içerisinde kullan:

  ```ruby
  Rails.application.credentials.dig(:foo, :bar, :baz)
  ```

Tenant Sırları
--------------

- Hangi tenant için işlem yapacaksanız ilgili engine'in bulunduğu dizine düşün:

  ```bash
  cd plugins/tenant/$SOME_TENANT
  ```

- Tenant sırlarını görüntüle:

  ```bash
  RAILS_MASTER_KEY=$TENANT_MASTER_KEY rails credentials:show
  ```

- Tenant sırlarını düzenle:

  ```bash
  RAILS_MASTER_KEY=$TENANT_MASTER_KEY rails credentials:edit
  ```

- Tenant sırlarını uygulama içerisinde kullan:

  ```ruby
  Nokul::Tenant.credentials.dig(:foo, :bar, :baz)
  ```
