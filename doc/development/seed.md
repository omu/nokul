---
author: M. Serhat Dundar
---

Seed
====

- `rake db:seed` varsayılan olarak export edilmiş seed verisini içeren .SQL dosyasını içeri aktarır.

- Export edilmiş seed verisini ignore ederek API üzerinden yeni veriye erişmek istiyorsanız `rake db:seed SYNC=true`
  çalıştırın.

- `rake db:seed` varsayılan olarak demo verisini içeri aktarmaz, yalnızca uygulamanın ayaklanması için gerekli veriyi
  içeri aktarır.

- Demo veriyi de içeri aktarmak istiyorsanız `rake db:seed SAMPLE_DATA=true` çalıştırın.

- Demo veriyi içeri aktarırken export dosyasını ignore etmek istiyorsanız `rake db:seed SYNC_true SAMPLE_DATA=true`
  çalıştırın.
