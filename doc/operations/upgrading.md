---
author(s):
  - M. Serhat Dundar (@msdundar)
---

App Upgrade
===========

Bu işlem yalnızca repository yöneticileri tarafından gerçekleştirilebilir:

```bash
bin/rails app:update
```

Dependency Upgrade
------------------

Bağımlılıklar güncellenirken hem nokul uygulamasının, hem de içerdiği plug-in ve engine'lerin bağımlılıkları güncellenmelidir.

```bash
bundle update
cd plugins/support && bundle update && cd -
cd plugins/tenant/common && bundle update && cd -
cd plugins/tenant/omu && bundle update && cd -
```

Version Bump
------------

`app.json` dosyasından uygulama sürümünü güncelleyin.
