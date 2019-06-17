---
author(s):
  - Hüseyin Tekinaslan (@huseyin)
---

Docker
======

Docker Compose
--------------

Nokul'u kendi bilgisayarınızda çalıştırmak için Docker Compose uygulamasını kullanabilirsiniz. Docker Compose'u
bilgisayarınızda çalıştırmak için Docker ve Docker Compose'u başarıyla bilgisayarınıza kurmanız gerekmektedir.

- [Docker Kurulumu](https://github.com/omu/omu/blob/master/doc/docker.md)
- [Docker Compose Kurulumu](https://github.com/omu/omu/blob/master/doc/docker-compose.md)

`docker-compose`'u kullanarak uygulamayı ayağa kaldırmadan önce proje kökünde bulunan `.env` dosyası içindeki
değişkenkeri doldurmanız gerekmektedir.

`.env` dosyası içeriği:

```sh
RAILS_ENV=development
NODE_ENV=development
RAILS_MASTER_KEY=xxxxxxxx
```

```sh
docker-compose build web
docker-compose run web sh -c "bundle install -j4 --path /app/vendor/bundle && yarn install"
docker-compose run web rails db:create db:structure:load db:seed
docker-compose up web
```

`http://localhost:3000` adresinden uygulamaya erişebilirsiniz.
