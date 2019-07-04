---
author(s):
  - İrfan Subaş (@isubas)
---

Component Yardımcıları
======================

View'ler içerisinde kullanılacak basit html bileşenler oluşturmak için kullanılabilecek metodları içeren helper modülüdür.

Bileşenler
----------

- list_group_tag
- klass_for_status

### list_group_tag

Bir dizinin hızlı bir şekilde liste görünümüne dönüştürülmesi sağlayan yardımcı metoddur.

#### Argümanlar

- **items: (zorunlu)** Listede görüntülenecek değer dizisi
- **ul_class: (opsiyonel)** *ul* etiketinin css class özelliği *(Default: list-group)*
- **li_class: (opsiyonel)** *li* etiketinin css class özelliği *(Default: list-group-item)*

#### Kullanım

```erb
  <%= list_group_tag(%w[foo bar]) %>
```

```html
  <ul class="list-group">
    <li class="list-group-item">foo</li>
    <li class="list-group-item">bar</li>
  </ul>
```

### klass_for_status

Belirlenen durum değerleri için daha önceden belirlelen css class değerini döndüren yardımcı metoddur.

Durumlara ve class eşleştirme bilgilerine `ComponentHelper::STATUSES` sabit üzerinden bakabilirsiniz.

#### Argümanlar

- **status: (zorunlu)** css class değeri istenen durum bilgisi

#### Kullanım

```erb
  <span class="badge badge-<%= klass_for_status('failed') %>">Durum</span>
```

```html
  <span class="badge badge-danger">Durum</span>
```
