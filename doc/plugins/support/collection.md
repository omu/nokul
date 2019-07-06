---
author(s):
  - Recai Oktaş (@roktas)
---

`Collection`
============

Bu sınıf özellikle YAML gibi bir kaynaktan okunan tek seviyeli sözlük türünde
basit veri elemanlarıyla çalışırken kullanabileceğiniz bir delegatördür.
Özellikle `Structure` modülüyle birlikte etkili bir ikili oluşturur.  Üzerinde
çalıştığınız problemde basitçe tekil/çoğul kalıplarıyla karşılaşmışsanız, ör.
`FalanFilan` ve `FalanFilans` (ehmm, `FalanFilanlar`), basit durumlarda bu
ikiliyi kullanmayı deneyebilirsiniz.

Aşağıdaki YAML içeriğini göz önüne alalım:

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

Bu örnekte (`Structure` örneğini hatırlarsak) `Unit` nesneleri yani
`Units` var.

```ruby
class Unit
  class_attribute :units, default: []

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

class Units < Collection
  def list_by_unit_type_id(unit_type_id)
    select { |unit| unit.unit_type_id == unit_type_id }
  end
end

units = Units.create [
  {
    'name' => 'Mühendislik Fakültesi',
    'abbreviation' => 'MÜHENDİSLİK',
    'yoksis_id' => '122183',
    'unit_type_id' => 'Fakülte'
  },
  {
    'name' => 'Bilgisayar Mühendisliği Bölümü',
    'abbreviation' => 'BİLGİSAYAR',
    'yoksis_id' => '122184',
    'unit_type_id' => 'Bölüm'
  }
]

units.list_by_unit_type_id('Fakülte').size #=> 1
```

`Collection` sınıfından miras alan çocuk sınıflar siz açıkça belirtmediğiniz
sürece kolleksiyonda yer alan nesnelerin sınıfını otomatik olarak seçer.
Örneğin `Units < Collection` sınıfı kolleksiyonda yer alan nesnelerin `Units`
isminin tekil hali olan `Unit` olduğunu biliyor.  Eğer otomatik çözümlemeyi
istemiyorsanız veya (sınıf adınının uygun koşullarda olmamasından dolayı)
işinizi görmüyorsa `collection.collects` atamasıyla koleksiyon nesnelerinin
hangi sınıfta beklendiğini söyleyebilirsiniz.

```ruby
class Departments < Collection
  collection.collects = Unit

  def list_by_unit_type_id(unit_type_id)
    select { |unit| unit.unit_type_id == unit_type_id }
  end
end
```

Örnekte görülen `collection` sınıf niteliği sınıf düzeyinde anlamlı
parametreleri (`collects` dışında) kaydedebileceğiniz bir
`ActiveSupport::OrderedOptions` nesnesi.

```ruby
class Foo < Collection
  collection.used = true
end

Foo.collection.used #=> true
```

Bu örnekte birimleri sınıflamak için özel bir `list_by_unit_type_id` metodu
yazılmıştır.  Amacınız bu tür sınıflamalar yapmak ve kolleksiyonda tekrarlı
elemanlardan kaçınmak ise `Collection` yerine `UniqCollection` sınıfını tercih
edin.
