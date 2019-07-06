---
author(s):
  - Recai Oktaş (@roktas)
---

`UniqCollection`
================

`Collection` sınıfından miras alan bu sınıfın atasından tek farkı içteki dizinin
bir `Set` olarak tutulmasıdır.  Bu sayede dizide tekrar eden ögeler bulunmaz ve
`Set` ile gelen ilave özelliklere de sahip olursunuz.

Sınıfın `Structure` ile birlikte kullanımını örneklemek için aşağıdaki içerikte
bir `units.yml` dosyasını göz önüne alın.

```yaml
- name: Mühendislik Fakültesi
  abbreviation: MÜHENDİSLİK
  yoksis_id: 122183
  unit_type_id: Fakülte

- name: Bilgisayar Mühendisliği Bölümü
  abbreviation: BİLGİSAYAR
  yoksis_id: 122184
  unit_type_id: Bölüm
```

Bu dosyadan hareketle her biri `Unit` nesnesi olan bir `Units` kolleksiyonu
oluşturmak için:

```ruby
class Unit
  include Structure.of %i[
    name
    abbreviation
    yoksis_id
    unit_type_id
  ]

  def faculty?
    unit_type_id == 'Fakülte'
  end
end

units = Units.read_from_yaml_file('units.yml')
units.classify { |unit| unit.unit_type_id } # birim türüne göre grupla
```

Görüldüğü gibi `Set` sayesinde kolleksiyonda kolaylıkla sınıflama
yapılabilmektedir.  Örneklenen `read_from_yaml_file` sınıf metoduna ilave olarak
bir kolleksiyonu YAML dosyaya yazmak için `write_to_yaml_file` sınıf metodunu
kullanabilirsiniz.

```ruby
units = Units.read_from_yaml_file('units.yml')
units.second.unit_type_id = 'Fakülte'

Units.write_to_yaml_file('units_updated.yml', units, comment: 'Güncellenen dosya')
```
