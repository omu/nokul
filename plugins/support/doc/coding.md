---
author: Recai Oktaş
---

`Coding`
========

`Coding` modülü entitelere kod ataması yapmakta kullanılan sınıflardan
oluşmaktadır.  `Coding::Generator` kod üreten jeneratör sınıfı, `Coding::Code`
kodu temsil eden tip sınıfı, `Coding::Memory` ise tekil kodlar üretmek için
gerekli hafızayı modelleyen sınıftır.

Kod nesneleri
-------------

Kodlama `Code` nesneleri üzerinden yürütülmektedir.  Code nesnelerinin temsil
ettiği "kodu" sadece rakam ve büyük harflerden oluşan bir dizgi olarak
tanımlıyoruz.  Kod içeriğinde sadece `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ`
karakterleri olabilir.  Temsil edilen kodu `Code` nesnesinden almak için `to_s`
string dönüşümünü kullanıyoruz.

Bir dizgi ("string") ile ilklendirilen `Code` nesnesi bir aralık içinde sonraki
("succeeding") kodu üretebilen, `Range` nesnelerinde kullanılabilen bir veri
tipini temsil etmektedir.

```ruby
code = Coding::Code.new '009'
code.succ.to_s #=> '010'

Coding::Code.new '013' < Coding::Code.new '020' #=> true

range = Coding::Code.new('033')..Coding::Code.new('035')
range.last.to_s #=> '035'
range.to_a(&:to_s) #=> ['033', '034', '035']
```

Örnekte görüldüğü gibi `Code` nesnesi `succ` metoduna cevap vererek bir sonraki
kod nesnesini üretebilmektedir (`succ` daima yeni bir `Code` nesnesi üretir).
Sonraki kodun ne değer alacağı, ön tanımlı davranış olarak, kod nesnesi
ilklendiğinde verilen dizgi argümanıyla belirlenir.

- Sadece rakamlardan oluşan bir ilk değerde sonraki kod, soldaki sıfırlar
  korunmak kaydıyla onlu tabandaki artışa göre belirlenir.

  ```ruby
  Coding::Code.new('009').succ.to_s #=> '010'
  ```

- İlk değerde `ABCDEF` harflerinden en az birisi görülmüş ve başka bir harf
  görülmemişse sonraki kod, soldaki sıfırlar korunmak kaydıyla onaltılı
  tabandaki artışa göre belirlenir.

  ```ruby
  Coding::Code.new('00A').succ.to_s #=> '00B'
  ```

- İlk değerde `ABCDEF` dışındaki diğer harflerinden en az birisi görülmüşse
  sonraki kod, soldaki sıfırlar korunmak kaydıyla otuzaltılı tabandaki artışa
  göre belirlenir.

  ```ruby
  Coding::Code.new('00G').succ.to_s #=> '00H'
  ```

Görüldüğü gibi kodlarda değer artışlarında sadece on, onaltı ve otuzaltı
tabanları kullanılmakta ve seçilen taban ilk değere göre otomatik
belirlenmektedir.  Otomatik seçim kullanılmadan tabanı açıkça vermek
isteyebilirsiniz.

```ruby
Coding::Code.new('0AF', 36).succ.to_s #=> '0AG`, `0B0` değil!
```

Kod üretimi
-----------

Kod üretimi `Code` nesneleriyle iklendirilen `Generator` nesnesiyle yapılır.

```ruby
generator = Coding::Generator.new '000'
generator.generate #=> '000'
generator.generate #=> '001'
```

Üretilen kodun bir hanesinde sadece belirli karakterler kullanılmasını
isteyebilirsiniz.

```ruby
generator = Coding::Generator.new '000', deny: /0$/
generator.generate #=> '001'
generator.generate #=> '002'
```

Örnekte görüldüğü gibi `deny` isimlendirilmiş argümanında tanımlayacağımız bir
düzenli ifade ile belirli karakterleri sınırlayabiliyoruz.

Kod üretiminin başlangıcı ilk argümanla verilirken, isteğe bağlı olarak, bitişi
`ends` argümanıyla belirtilir.

```ruby
generator = Coding::Generator.new '000', ends: '003'
generator.generate #=> '000'
generator.generate #=> '001'
generator.generate #=> '002'
generator.generate #=> '003'
generator.generate #=> Coding::Generator::Consumed exception
```

Görüldüğü gibi sona ulaşıldığında üreteç nesnesi `Coding::Generator::Consumed`
istisnası üretir.  Bu istisnayı yakalayarak süreci kontrol edebilirsiniz.

Kod üreteçleri sadece tek kodlar üretmek yerine bir kod havuzu da (dizi)
üretebilir.


```ruby
generator = Coding::Generator.new '000', ends: '003'

pool  = generator.pool   #=> ['000', '001', '002', '003']
```

Geçmişe bağlı kod üretimi
-------------------------

Pek çok kullanım senaryosunda kod üretecinin geçmişte kullanılmayan tekil kodlar
üretmesi istenir.  Bu amaçla üretece `memory` isimlendirilmiş argümanıyla
verilen `Coding::Memory` nesnesinden yararlanacaksınız.  Ön tanımlı davranışta
kod üreteci `Coding::NilMemory` nesnesiyle hafızasız davranır.

```ruby
class Generator
  def initialize(seed, ends: nil, allowed: nil, memory: NilMemory.new)
    ...
  end
end
```

Geçmişi kaydeden basit sözlük türünde bir hafıza kullanabilirsiniz.  Bu amaçla
hazır `Coding::SimpleMemory` nesnesini kullanabilirsiniz.

```ruby
memory = Coding::SimpleMemory.new { '002' => true }
generator = Coding::Generator.new '000', memory: memory
generator.generate #=> '000'
generator.generate #=> '001'
generator.generate #=> '003', '002' hatırlandı
```

`SimpleMemory` nesnesinin yeterli gelmediği durumlarda kendi hafıza nesnenizi
yazmak durumundasınız.  Hafıza nesneleri sadece iki metoda: `remember` ve
`remember?` cevap veren baist nesnelerdir;  `remember` metodu argüman olarak
verilen bir kod dizgisini saklar, `remember?` metodu ise argüman olarak verilen
bir kod dizgisinin hafızada olup olmadığını döner.

Örneğin tamamen veritabanından çalışan bir hafıza nesnesi oluşturmak isterseniz
aşağıdaki sınıf tanımını yapabilirsiniz.

```ruby
class DatabaseMemory < Coding::Memory
  def initialize
    # Veritabanından ilkle
  end

  def remember(string)
    # Veritabanını güncelle
  end

  def remember?(string)
    # Veritabanından sorgula
  end
end
```

Numara üretimi
--------------

Kod üretiminin özel bir hali olarak `Numerator` sınıfları kullanılabilir.
Bunların en yaygını `PrefixedNumerator` sınıfıdır.


```ruby
numerator = PrefixedNumerator.new '001', leading_prefix: '203', trailing_prefix: '19'
numerator.number #=> 20319001
numerator.number #=> 20319002

numerator.next_sequence  #=> 003 (numerator çekirdeğini değiştirmez)
numerator.first_sequence #=> 001

numerator = numerator('203', '078')

numerator.number #=> 20319078
numerator.number #=> 20319079
```

Örnekte de görüldüğü gibi `PrefixedNumerator` sayacı `leading_prefix
trailing_prefix sequence` biçiminde sayılar üretir.  Üretilen sayı öntanımlı
olarak 8 hanedir.  Ön eklerin varlığından dolayı ardışımın uzunluğu 8 değerinden
çok daha küçüktür (yukarıdaki örnekte 3 hane).  Ardışım için daha fazla sayıda
haneye ihtiyacınız varsa `trailing_prefix` değerini girmeyebilirsiniz.

```ruby
long_numerator = PrefixedNumerator.new '001', leading_prefix: '203'

long_numerator.number #=> 20300001
long_numerator.number #=> 20300002

long_numerator.next_sequence  #=> 00003
long_numerator.first_sequence #=> 00001

long_numerator = long_numerator('203', '078')

long_numerator.number #=> 20300078
long_numerator.number #=> 20300079
```

`PrefixedNumerator` sınıfı `AbstractNumerator` sınıfından miras almaktadır.
Kendi özel numeratörünüzü bu soyut sınıftan miras alarak tanımlayabilirsiniz.

```ruby
class FlatNumerator < AbstractNumerator
  self.length = 12

  def number
    generator.generate
  end

  def first_sequence
    '0' * (self.class.length - 1) + '1'
  end
end
```

Örnekte görüldüğü gibi yapmanız gereken asgari olarak `number` ve
`first_sequence` metodlarını somut sınıfta gerçeklemektir.
