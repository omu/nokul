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

Bu ortam değişkeni olmadığında sistem veritabanından yetkilendirmeye çalışacaktır. LDAP'taki ve veritabanındaki kullanıcı
parolaları aynı olduğundan, kullanıcılar başarılı bir şekilde sisteme giriş yapabilmeye devam edebileceklerdir.
