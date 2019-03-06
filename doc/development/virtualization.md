Sanallaştırma
=============

Vagrant
-------

Nokul'un geliştirilme süreçlerinde depoda kayıtlı Vagrantfile üzerinden
Vagrant'ı kullanabilirsiniz.  Bunun öncesinde ilgili hipervizörleri ve
Vagrant'ı başarıyla kurmuş ve yapılandırmış olmanız gerekiyor:

- [Vagrant kurulumu](https://github.com/omu/omu/blob/master/doc/vagrant.md)

- [LXC kurulumu](https://github.com/omu/omu/blob/master/doc/lxc.md)

- [Virtualbox kurulumu](https://github.com/omu/omu/blob/master/doc/virtualbox.md)


Projenin Vagrantfile dosyasında aşağıdaki sanal makineler tanımlıdır.

| Makine | Hipervizör | Port | İmaj                       |
|--------|------------|------|----------------------------|
| `dev`  | LXC        | 3000 | `omu/debian-stable-server` |
| `ldap` | LXC        | 1389 | `omu/debian-stable-server` |
| `paas` | Virtualbox | -    | `omu/debian-stable-server` |


Bu makineleri çalıştırmak için adını (ve ilk çalıştırmada hipervizörü)
belirtmeniz gerekir:

```sh
vagrant up --provider=lxc # öntanımlı dev makinesini çalıştırır
vagrant up dev --provider=lxc
vagrant up ldap --provider=lxc
vagrant up paas # hipervizör gerekmiyor, zaten öntanımlı
```

Bu komutlar ilk çalıştırma için geçerlidir.  Sonraki `up/halt` çevrimlerinde
hipervizör belirtmeniz gerekmez.

`VAGRANT_DEFAULT_PROVIDER` ortam değişkeniyle ön tanımlı hipervizör
değiştirilmedikçe daima Virtualbox'ın seçileceğini unutmayın.  Örneğin aşağıdaki
komut `dev` makinesini Virtualbox hipervizörüyle çalıştırma girişiminde bulunur:

```sh
vagrant up # dev makinesi Virtualbox ile çalıştırılır
```

#### `dev`

Geliştirme amaçlı makine.  Tüm `omu/debian-stable-server` imajlarında olduğu
gibi bu makinede uygulama `/app` dizininde bulunur.  `/app` dizini `/vagrant`
dizinine sembolik bağlı olduğundan `/app` dizini aynı zamanda Vagrant
paylaştırılmış dizinidir (fakat uygulamanın yeri konusundaki kabulunüzü daima
`/app` olarak yapın).

Nokul servisi sanal makinede kurulu `/usr/local/bin/app` aracıyla `Procfile`
üzerinden etkinleştirilmektedir.  Bu etkinleştirme ilk `vagrant up` komutunda
otomatik gerçekleşir.  Geliştirme sırasında makineye `vagrant ssh` ile girerek
uygulamayı aşağıdaki komutlarla yönetebilirsiniz:

- Uygulamayı yeniden başlat

  ```sh
  sudo app restart # veya sadece sudo app
  ```

- Uygulamayı durdur

  ```sh
  sudo app stop
  ```

- Uygulamanın durumunu incele

  ```sh
  sudo app status
  ```

  Bu komut aslında `journalctl` ile uygulamanın systemd loglarını görüntüler.
  Sistem günlüğünü ayrıntılı görmek isterseniz:

  ```sh
  sudo journalctl
  ```

  Bu komut özellikle uyglama cevap vermediğinde sorunu çözmenize yardımcı
  olacaktır.

Uygulamanın konuşlandırmasında aşağıdaki dosyalar rol almaktadır (dosya yolları
makinedeki konumları göstermektedir):

- `/app/Procfile`: Uygulama etkinleştirildiğinde çalışacak prosesler ve bunların
  nasıl çalıştırılacağı.  Çalışmasını istemediğiniz prosesleri bu dosyada
  etkisizleştirebilirsiniz.

- `/etc/environment`: Uygulama çalışırken etkin olacak ortam değişkenleri.

Provizyonlamada Rails `db:seed` adımını atlamak isterseniz `DEPLOY_SKIP_SEED`
ortam değişkenini kullanın.

```sh
DEPLOY_SKIP_SEED=true vagrant up --provider=lxc
```

#### `ldap`

Geliştirme sırasında kimliklendirme için LDAP sunucusuna ihtiyaç olduğunda
kullanılacak makine.

#### `paas`

Sistem yöneticilerinin Dokku tabanlı PaaS üzerinde deneme yapmaları için
kullanılan devops makinesi.  Normal şartlarda geliştiricilerin bu makineye
ihtiyacı yoktur.  Gerçek konuşlandırma koşullarını test etmek istiyorsanız
kullanabilirsiniz.

```sh
vagrant up paas --provider=virtualbox
RAILS_MASTER_KEY=xxxxxx vagrant provision paas
git push --no-verify dokku YEREL_DAL_ADI:master
```

#### `docker-compose`

Nokul'u kendi bilgisayarınızda çalıştırmak için Docker Compose uygulamasını
kullanabilirsiniz. Docker Compose'u bilgisayarınızda çalıştırmak için Docker
ve Docker Compose'u başarıyla bilgisayarınıza kurmanız gerekmektedir.

- [Docker Kurulumu](https://github.com/omu/omu/blob/master/doc/docker.md)
- [Docker Compose Kurulumu](https://github.com/omu/omu/blob/master/doc/docker-compose.md)

`docker-compose`'u kullanarak uygulamayı ayağa kaldırmadan önce proje kökünde
bulunan `.env` dosyası içindeki değişkenkeri doldurmanız gerekmektedir.

`.env` dosyası içeriği:
```
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
