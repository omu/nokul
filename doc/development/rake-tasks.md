---
author(s):
  - M. Serhat Dundar (@msdundar)
  - Hüseyin Tekinaslan (@huseyin)
---

Rake Görevleri
==============

- Uygulamada mevcut tüm Rake görevlerini listelemek için şu komutu çalıştır

  ```bash
  rake -T
  ```

- Bunun dışında spesifik bir görevi çalıştırmak için (harici olarak çekilen YOKSIS referansları gibi) aşağıdaki
  komutu çalıştır

  ```bash
  rake fetch:references
  ```

Genel olarak `fetch` ön eki API operasyonları, `import` ön eki ise CSV "import" işlemleri için kullanılmaktadır.
