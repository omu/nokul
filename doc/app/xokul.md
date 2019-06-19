---
author(s):
  - Hüseyin Tekinaslan (@huseyin)
---

Xokul
=====

[API servisine](https://api.omu.sh) erişim, herbir kiracı (tenat) için farklı üretilmiş JWT ile gerçekleştirilir. Daima
Nokul'da etkin olan kiracının (öntanımlı olarak OMU) "token"ı kullanılır.

JWT, `config/credentials.yml.enc` dosyasında şifreli halde saklanmaktadır. Düzenlemek için aşağıdaki komutu kullanın.

```sh
bin/rails credentials:edit
```

API yanıtları için [şuraya](https://github.com/omu/xokul/tree/dev/app/serializers) bakabilirsiniz.

Meksis
------

### `buildings`

Bina listesini getirir.

```ruby
Xokul::Meksis.buildings
```

### `classrooms`

Binadaki sınıf listesini getirir.

```ruby
Xokul::Meksis.classrooms(building_id)
```

- `building_id`: Bina id'sidir. Tüm bina id'lerini almak için [`buildings`](#buildings) kullanın.

### `syllabuses_by_classroom`

Sınıfa ait tüm ders programlarını getirir.

```ruby
Xokul::Meksis.syllabuses_by_classroom(classroom_id, year, term)
```

- `classroom_id`: Sınıf id'sidir. Tüm sınıf id'lerini almak için [`classrooms`](#classrooms) kullanın.
- `year`: Yıl (ör: 2018)
- `term`: Akademik dönem
  + `0`: Tüm yıl
  + `1`: Güz
  + `2`: Bahar
  + `3`: Yaz

### `syllabuses_by_unit`

Akademik bir birime (bölüm, fakülte gibi) ait tüm ders programlarını getirir.

```ruby
Xokul::Meksis.syllabuses_by_unit(unit_id, year, term)
```

- `unit_id`: Birimin Yoksis id'sidir.
- `year`: Yıl (ör: 2018)
- `term`: Akademik dönem
  + `0`: Tüm yıl
  + `1`: Güz
  + `2`: Bahar
  + `3`: Yaz
