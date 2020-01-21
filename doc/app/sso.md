---
author(s):
  - Emre Can Yılmaz (@ecylmz)
---

Single Sign-on
==============

Uygulamada SSO'yu aktif hale getirmek için aşağıdaki ortam değişkeni tanımlanmalıdır.

```text
NOKUL_SSO_ENABLE=true
```

Bu ortam değişkeni olmadığında sistem veritabanından yetkilendirmeye çalışacaktır. LDAP ve veritabanındaki kullanıcı
parolaları aynı olduğundan, kullanıcılar başarılı bir şekilde sisteme giriş yapabilmeye devam edebileceklerdir.

LemonLDAP
---------

LemonLDAP ve LLNG arasındaki bağlantı bir süre sonra kopuyor. Bununla LLNG depolarındaki issue [şudur][LLNG-1807].

Geçici çözüm:

LemonLDAP sunucusunda aşağıdaki gibi keepalive değerleri girilir:

```bash
$ vim /etc/sysctl
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_keepalive_intvl = 60
net.ipv4.tcp_keepalive_probes = 5
```

Yukarıdaki ayarlar şunu yapmaktadır:

Açık ve boşta olan bir TCP bağlantısına, 300 saniyenin ardından bağlantının hala hayatta olup olmadığını anlamak için
dakikada 1 istek atılır. 5 denemenin ardından eğer karşı taraftan yanıt alınamazsa bağlantı sonlandırılır. Bu kontroller
sırasında arada trafik oluştuğu için firewall bağlantıyı sonlandırmayacaktır.

[LLNG-1807]: https://gitlab.ow2.org/lemonldap-ng/lemonldap-ng/issues/1807
