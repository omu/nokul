`Simple`
========

Bu modül dizi ve yapısal (`Struct`) veri niteliğindeki nesneler üzerinde
çalışmayı kolaylaştıran iki sınıftan oluşuyor: `Simple::Collection` ve
`Simple::Container`.  Özellikle YAML gibi bir kaynaktan okunan tek seviyeli
sözlük türünde basit veri elemanlarıyla çalışmak için bu kitaplığı
kullanabilirsiniz.  **Veri yapısı basit değilse bu sınıfları kullanmak yerine
lütfen probleme özgü sınıflar oluşturarak onları kullanın.**  Modülün ismi de bu
koşulu yansıtıyor.

`Simple::Container`
-------------------

Bu **modülümsü** sınıf `Struct` sınıfına uygulanan ve pek çok olağan senaryoda
fazladan kod yazmadan sonuç almanızı sağlayan basit bir sarmalayıcı.  Sınıfın
kendisi `Module`'den miras aldığından katıştırma ("mixin) yaparak kullanılıyor.
Olağan kullanım senaryosu da zaten bu: hafif bir DSL üzerinden katıştırma
yapmak.

Her biri aşağıdaki YAML yapısında anahtar, değer çiftlerinden oluşan bir veriyi
göz önüne alalım:

```yaml
name: Mühendislik Fakültesi
abbreviation: MÜHENDİSLİK
yoksis_id: 122183
unit_type_id: Fakülte
```

Bu veri üzerinde ilave metodlar da ekleyerek çalışmak isterseniz:

```ruby
class Unit
  include Simple::Container.of %i[
    name
    abbreviation
    yoksis_id
    unit_type_id
  ]

  def faculty?
    unit_type_id == 'Fakülte'
  end
end

unit = Unit.new(name: 'Mühendislik Fakültesi', abbreviation: 'MÜHENDİSLİK',
                yoksis_id: '122183', unit_type_id: 'Fakülte')

unit.name     #=> "Mühendislik Fakültesi"
unit.faculty? #=> true

```

Görüldüğü gibi yapılması gereken basitçe yeni bir sınıf oluşturup
`Simple::Container.of` DSL'ini kullanarak ilgili nitelikleri listelemek.  Sınıfa
isimleri veri nitelikleriyle çakışmamak kaydıyla istediğiniz isim ve sayıda
metod ekleyebilirsiniz.

Nesne için `initialize` metodu yazmanız gerekmiyor, yazma olanağınız da yok.
Ama nesne inşa edilirken `initialize` sürecinde yapmayı istediğiniz bir işlem
varsa argüman almayan `after_initialize` metodunu kullanabilirsiniz.


```ruby
class Unit
  class_attribute :units, default: []

  include Simple::Container.of %i[
    name
    abbreviation
    yoksis_id
    unit_type_id
  ]

  def after_initialize
    self.class.units << name
  end

  def faculty?
    unit_type_id == 'Fakülte'
  end
end

Unit.units.size #=> 0

unit = Unit.new(name: 'Mühendislik Fakültesi', abbreviation: 'MÜHENDİSLİK',
                yoksis_id: '122183', unit_type_id: 'Fakülte')

Unit.units.size #=> 1

```

`Simple::Collection`
--------------------

Bu sınıf özellikle dizi türünde veriler üzerinden çalışırken kullanabileceğiniz
bir delegatör.  Bu sınıf özellikle `Simple::Container` sınıfıyla birlikte güzel
bir ikili oluşturuyor.

Üzerinde çalıştığınız problemde basitçe tekil/çoğul kalıplarıyla
karşılaşmışsanız, ör. `FalanFilan` ve `FalanFilans` (ehmm, `FalanFilanlar`),
basit durumlarda bu ikiliyi kullanmayı deneyebilirsiniz.

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

Bu örnekte (`Simple::Container` örneğini hatırlarsak) `Unit` nesneleri yani
`Units` var.

```ruby
class Unit
  class_attribute :units, default: []

  include Simple::Container.of %i[
    name
    abbreviation
    yoksis_id
    unit_type_id
  ]

  def faculty?
    unit_type_id == 'Fakülte'
  end
end

class Units < Simple::Collection
  def list_by_unit_type_id(unit_type_id)
    select { |unit| unit.unit_type_id == unit_type_id }
  end
end

units = Units.from_hashes [
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

`Simple::Collection` sınıfından miras alan çocuk sınıflar siz açıkça
belirtmediğiniz sürece kolleksiyonda yer alan nesnelerin sınıfını otomatik
olarak seçiyor.  Örneğin `Units < Simple::Collection` sınıfı kolleksiyonda yer
alan nesnelerin `Units` isminin tekil hali olan `Unit` olduğunu biliyor.  Eğer
otomatik çözümlemeyi istemiyorsanız veya (sınıf adınının uygun koşullarda
olmamasından dolayı) işinizi görmüyorsa `collection.collects` atamasıyla
koleksiyon nesnelerinin hangi sınıfta beklendiğini söyleyebilirsiniz.

```ruby
class Departments < Simple::Collection
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
class Foo < Simple::Collection
  collection.used = true
end

Foo.collection.used #=> true
```

Sınıf değil de kolleksiyon nesnelerinde bulunmasını istediğiniz nitelikler bir
`ActiveSupport::InheritableOptions` nesnesi olan `property` niteliğinde
tutuluyor.

```ruby
class Bars < Simple::Collection
  collection.used = true
end

class Bar
  include Simple::Container.of %i[x y z]
end

bars = Bars.from_hashes [
  { x: 3,  y: 5,  z: 8  },
  { x: 13, y: 19, z: 42 },
]

bars.property.ok = 'ok' #=> 'ok'

# Veya

bars = Bars.new_with_properties [
  { x: 3,  y: 5,  z: 8  },
  { x: 13, y: 19, z: 42 },
], ok: 'ok'

bars.property.ok #=> 'ok'
```

Son örnekte görüldüğü gibi `new_with_properties` metoduyla `property` niteliğini
kolleksiyon oluşturulurken doldurabilirsiniz.

Her iki sınıf da özellikle basit YAML dosyalarla çalışırken etkili oluyor.
Aşağıdaki içerikte bir `units.yml` dosyasını göz önüne alın

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
  include Simple::Container.of %i[
    name
    abbreviation
    yoksis_id
    unit_type_id
  ]

  def faculty?
    unit_type_id == 'Fakülte'
  end
end

class Units < Simple::Collection
  def list_by_unit_type_id(unit_type_id)
    select { |unit| unit.unit_type_id == unit_type_id }
  end
end

units = Units.read_from_yaml_file('units.yml')

units.list_by_unit_type_id('Fakülte').size #=> 1
```

Örneklenen `read_from_yaml_file` sınıf metoduna ilave olarak bir kolleksiyonu
YAML dosyaya yazmak için `write_to_yaml_file` sınıf metodunu kullanabilirsiniz.

```ruby
units = Units.read_from_yaml_file('units.yml')
units.second.unit_type_id = 'Fakülte'

units.list_by_unit_type_id('Fakülte').size #=> 2

Units.write_to_yaml_file('units_updated.yml', units, comment: 'Güncellenen dosya')
```
