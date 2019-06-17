---
author(s):
  - M. Serhat Dundar (@msdundar)
  - Hüseyin Tekinaslan (@huseyin)
---

Nokul Dokümantasyonu
====================

Burada Nokul'a ait dokümanlar yer almaktadır. Bu dokümanları kullanarak Nokul'u kullanmaya veya ona katkı vermeye
başlayabilirsiniz.

*Dokümanlara [https://doc.omu.sh/nokul](https://doc.omu.sh/nokul) üzerinden de ulaşabilirsiniz.*

İçerik
------

### Uygulama İç Yapısı

- [Kullanıcılar](app/user.md)
- [Birimler](app/unit.md)
- [Patron](app/patron.md)

### Operasyonlar

- [Kurulum](operations/installation.md)
- [Güncelleme](operations/upgrading.md)
- [Konuşlandırma](operations/deployment.md)

### Geliştirme

- [Rake Görevleri](development/tasks.md)
- [Testler](development/tests.md)
- [Seed İşlemleri](development/seeds.md)
- [Sırlar](development/secrets.md)
- [Docker](development/docker.md)
- [Vagrant](development/vagrant.md)

### Yardımcılar

- [Birim Testler](helpers/unit-test.md)
- [link_to_helper](helpers/link_to_helper.md)
- [dynamic_select](helpers/dynamic_select.md)

### Eklentiler

- Support
  + [Codification](plugins/support/codification.md)
  + [Collection](plugins/support/collection.md)
  + [Rest Client](plugins/support/rest_client.md)
  + [Sensitive](plugins/support/sensitive.md)
  + [Structure](plugins/support/structure.md)
  + [Uniq Collection](plugins/support/uniq_collection.md)
  + [Çekirdek Eklentileri](plugins/support/core_ext.md)
- Tenant
  + Ortak
    - Geliştirme
      + [Nokul::Tenant::Codification](plugins/tenant/common/development/codification.md)
      + [Nokul::Tenant](plugins/tenant/common/development/tenant.md)
      + [Nokul::Tenant::Units](plugins/tenant/common/development/units.md)
    - Spesifikasyonlar
      + [Öğrencilerin Numaralandırılması](plugins/tenant/common/specification/student-numbers.md)
      + [Birimlerin Kodlanması](plugins/tenant/common/specification/unit-codes.md)
      + [Birim Kısaltmaları](plugins/tenant/common/specification/unit-abbreviations.md)
      + [Kullanıların İsimlendirilmesi](plugins/tenant/common/specification/user-names.md)
