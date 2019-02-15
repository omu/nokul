---
author: M. Serhat Dundar
---

# App Upgrade

Bu işlem yalnızca repository yöneticileri tarafından gerçekleştirilebilir:

```bash
bin/rails app:update
```

# Dependency Upgrade

Bağımlılıklar güncellenirken hem nokul uygulamasının, hem de içerdiği plug-in ve engine'lerin bağımlılıkları güncellenmelidir.

```bash
bundle update
cd plugins/support && bundle update
cd plugins/tenant/common && bundle update
cd plugins/tenant/omu && bundle update
