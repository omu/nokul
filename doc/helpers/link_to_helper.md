---
author: İrfan Subaş
---

Link Yardımcıları
=================

Uygulama içerisinde aynı işleve sahip linklerin aynı görünüme sahip olmasını
sağlamak amacıyla geliştirilmişlerdir. Kullanımın bakımından `link_to` metodu ile
benzerlik göstermektedir.

### Yardımcı Metodlar

- link_to_back
- link_to_destroy
- link_to_edit
- link_to_file
- link_to_new
- link_to_show
- link_to_update
- **link_to_actions**

#### Temel Kullanım Örnekleri

**Not:** Bu örnekler, `link_to_actions` haricindeki diğer yardımcılar için geçerlidir.

```erb
  <%= link_to_show(course_path(course)) %>
  <%= link_to_edit('A Dersini Güncelle', edit_course_path(course)) %>
```

#### İleri Seviye Kullanım Örnekleri

```erb
  <%= link_to_destroy('Dersi Sil'
                      edit_course_path(course),
                      class: 'btn btn-danger') %>

  <%= link_to_destroy(edit_course_path(course),
                      class: 'btn btn-danger',
                      id: 'destroy-button',
                      data: { object_id: 1 } ) %>
```

### link_to_actions

Görüntüleme, düzenleme ve silme işlevleri için gerekli linkleri tek bir metod ile
oluşturmanızı sağlayan yardımcı bir metoddur.

### Temel Kullanım Örnekleri

Metoda, yalnızca **path** parametresi gönderilirse, 3 action içinde link üretecektir.
**except** parametresini kullanarak dilediğiniz actionların hariç tutabilirsiniz. Ek olarak **scope** parametresini kullanarak linklerin hangi
kapsam için oluşturulacağını belirleyebilirsiniz.

```erb
  <%= link_to_actions(object) %>
  <%= link_to_actions(object, except: %i[show destroy]) %> # object_path
  <%= link_to_actions(object, except: :show, scope: :admin) %> # admin_object_path
```

#### İleri Seviye Kullanım Örnekleri

Her bir action için text, icon ve link opsiyonlarını belirleyebilirsiniz.

```erb
  <%= link_to_actions(object,
                      show: {
                        text: '',
                        icon: 'fa fa-pencil',
                        options: { class: 'btn btn-danger' }
                      },
                      edit: {
                        text: 'Nesneyi Düzenle',
                        options: {
                          data: { confirm: 'Edit Confirm' }
                        }
                      }) %>
```
