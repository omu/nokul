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

**Not:** Tüm Xokul metotları aşağıdaki durumlar oluştuğunda `nil` dönecektir. Bununla ilgili log düşülmektedir. Detaylı
bilgi için Rails loglarını takip edin.

- REST istemcisi boş gövde (body) döndüğünde (ki bu `204 "No Content"` hata koduna sahiptir)
- REST istemcisi `200 "HTTP OK"` dışında bir yanıt döndürdüğünde
- Yanıt gövdesi JSON ile "parse" edilirken bir hata meydana geldiğinde

Yukarıdaki durumu programatik olarak şu şekilde kullanılabilir:

```ruby
resp = Xokul::Meksis.buildings
resp.each(&:puts) if resp
```

YÖKSİS
------

### Prospectives

#### `all`

Tüm aday öğrenci listesini getirir. Sorguda kullanılan `type` aşağıdakilerden
birisi olabilir:

- YKS (Yükseköğretim Kurumları Sınavı)
- YKS_EK (YKS Ek Yerleştirme)
- YKS_MS (YKS Milli Sporcu)
- DGS (Dikey Geçiş Sınavı)
- DGS_EK (DGS Ek Yerleştirme)
- LT (Lisans Tamamlama)

```ruby
type = 'YKS'
year = 2019
Xokul::Yoksis::Prospectives.all type, year
```

#### `through_electronic`

Elektronik ortam aracılığıyla kaydolan aday öğrencileri getirir.

```ruby
type = 'YKS'
year = 2019
Xokul::Yoksis::Prospectives.through_electronic type, year
```

#### `without_electronics`

Elektronik ortam dışındaki herhangi bir yolla kaydolan öğrencileri getirir.

```ruby
type = 'YKS'
year = 2019
Xokul::Yoksis::Prospectives.without_electronics type, year
```

#### `student`

Elektronik ortam aracılığıyla kaydolan aday öğrencileri getirir.

```ruby
type = 'YKS'
year = 2019
id_number = '11111111111'
Xokul::Yoksis::Prospectives.student type, year, id_number
```

#### `photo`

Aday öğrencinin fotoğrafını döndürür.

```ruby
id_number = '11111111111'
Xokul::Yoksis::Prospectives.photo id_number
```

#### Pagination

Pagination yalnızca aşağıdaki metotlar için kullanılabilir.

- `students`
- `through_electronic`
- `without_electronics`

```ruby
type = 'YKS'
year = 2019
Xokul::Yoksis::Prospectives.without_electronics type, year, page: 3, per_page: 100
```

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
