---
author: Recai Oktaş
---

`Structure`
===========

Bu **modülümsü** sınıf `Struct` sınıfına uygulanan ve pek çok olağan senaryoda
fazladan kod yazmadan sonuç almanızı sağlayan basit bir sarmalayıcıdır.  Sınıfın
kendisi `Module`'den miras aldığından katıştırma ("mixin") yaparak kullanılıyor.
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

unit = Unit.new(name: 'Mühendislik Fakültesi', abbreviation: 'MÜHENDİSLİK',
                yoksis_id: '122183', unit_type_id: 'Fakülte')

unit.name     #=> "Mühendislik Fakültesi"
unit.faculty? #=> true

```

Görüldüğü gibi yapılması gereken basitçe yeni bir sınıf oluşturup
`Structure.of` DSL'ini kullanarak ilgili nitelikleri listelemek.  Sınıfa
isimleri veri nitelikleriyle çakışmamak kaydıyla istediğiniz isim ve sayıda
metod ekleyebilirsiniz.

Nesne için `initialize` metodu yazmanız gerekmiyor, yazma olanağınız da yok.
Ama nesne inşa edilirken `initialize` sürecinde yapmayı istediğiniz bir işlem
varsa argüman almayan `after_initialize` metodunu kullanabilirsiniz.


```ruby
class Unit
  class_attribute :units, default: []

  include Structure.of %i[
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
