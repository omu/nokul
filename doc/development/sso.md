---
author(s):
  - Emre Can Yılmaz (@ecylmz)
---

Single Sign-on
==============

Geliştirme ortamında Single Sign-On(SSO) denemeleri yapmak için Vagrant ile çalışmanız gerekiyor. Çalışma ortamını hazır
hale getirmek için aşağıdaki komutlar uygulanır:

```sh
vagrant up ldap --provider=lxc
vagrant up dev --provider=lxc
vagrant up sso --provider=lxc
```

Nokul'da SSO'yu etkinleştirmek için `.env` dosyasına aşağıdaki satırı ekleyin:

```text
NOKUL_SSO_ENABLE=true
```

Nokul uygulamasına SSO üzerinden giriş yapabilmek için bir kullanıcınızın olması gerekiyor. Kullanıcınızı hazır hale
getirmek için aşağıdaki komutları rails konsoluna girmelisiniz:

```ruby
user = User.find_by(id_number: "Geliştirici ekibe sor")
user.password = 12345
user.password_confirmation = 12345
user.activated = true
user.save(validate: false)
LDAP::Entity.create(user)
```

`vagrant ssh dev` diyerek dev sanal makinesine girip uygulamayı durdurun. Uygulamayı ssl kullanarak başlatmak için şunu
başlatın:

```bash
sudo app stop
cd /app
bundle exec rails s -b 'ssl://0.0.0.0:3000?key=/etc/ssl/private/ssl-cert-snakeoil.key&cert=/etc/ssl/certs/ssl-cert-snakeoil.pem'
```

Uygulamaya giriş için `https://other.vagrant.ga:3000` adresine gidin.

LemonLDAP
---------

LemonLDAP ile ilgili yapılandırmalar için `https://manager.sso.vagrant.ga` adresine girin.

```text
Kullanıcı: cezmi
Parola: 12345
```
