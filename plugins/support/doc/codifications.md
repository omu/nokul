---
author: Recai Oktaş
---

`Codifications`
===============

`Codifications` modülü entitelere kod ataması yapmakta kullanılan sınıflardan
oluşmaktadır.  `Codifications::Coder` kod üreten jeneratör sınıfı,
`Codifications::Code` kodu temsil eden tip sınıfı, `Codifications::Memory` ise
tekil kodlar üretmek için gerekli hafızayı modelleyen sınıftır.

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
code = Codifications::Code.new '009'
code.succ.to_s #=> '010'

Codifications::Code.new '013' < Codifications::Code.new '020' #=> true

range = Codifications::Code.new('033')..Codifications::Code.new('035')
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
  Codifications::Code.new('009').succ.to_s #=> '010'
  ```

- İlk değerde `ABCDEF` harflerinden en az birisi görülmüş ve başka bir harf
  görülmemişse sonraki kod, soldaki sıfırlar korunmak kaydıyla onaltılı
  tabandaki artışa göre belirlenir.

  ```ruby
  Codifications::Code.new('00A').succ.to_s #=> '00B'
  ```

- İlk değerde `ABCDEF` dışındaki diğer harflerinden en az birisi görülmüşse
  sonraki kod, soldaki sıfırlar korunmak kaydıyla otuzaltılı tabandaki artışa
  göre belirlenir.

  ```ruby
  Codifications::Code.new('00G').succ.to_s #=> '00H'
  ```

Görüldüğü gibi kodlarda değer artışlarında sadece on, onaltı ve otuzaltı
tabanları kullanılmakta ve seçilen taban ilk değere göre otomatik
belirlenmektedir.  Otomatik seçim kullanılmadan tabanı açıkça vermek
isteyebilirsiniz.

```ruby
Codifications::Code.new('0AF', 36).succ.to_s #=> '0AG`, `0B0` değil!
```

Kod üretimi
-----------

Kod üretimi `Code` nesneleriyle iklendirilen `Coder` nesnesiyle yapılır.

```ruby
coder = Codifications::Coder.new '000'
coder.generate #=> '000'
coder.generate #=> '001'
```

Üretilen kodun bir hanesinde sadece belirli karakterler kullanılmasını
isteyebilirsiniz.

```ruby
coder = Codifications::Coder.new '000', deny: /0$/
coder.generate #=> '001'
coder.generate #=> '002'
```

Örnekte görüldüğü gibi `deny` isimlendirilmiş argümanında tanımlayacağımız bir
düzenli ifade ile belirli karakterleri sınırlayabiliyoruz.

Kod üretiminin başlangıcı ilk argümanla verilirken, isteğe bağlı olarak, bitişi
`ends` argümanıyla belirtilir.

```ruby
coder = Codifications::Coder.new '000', ends: '003'
coder.generate #=> '000'
coder.generate #=> '001'
coder.generate #=> '002'
coder.generate #=> '003'
coder.generate #=> Codifications::Coder::Consumed exception
```

Görüldüğü gibi sona ulaşıldığında üreteç nesnesi
`Codifications::Coder::Consumed` istisnası üretir.  Bu istisnayı yakalayarak
süreci kontrol edebilirsiniz.

Kod üreteçleri sadece tek kodlar üretmek yerine bir kod havuzu da (dizi)
üretebilir.


```ruby
coder = Codifications::Coder.new '000', ends: '003'

pool  = coder.pool   #=> ['000', '001', '002', '003']
```

Geçmişe bağlı kod üretimi
-------------------------

Pek çok kullanım senaryosunda kod üretecinin geçmişte kullanılmayan tekil kodlar
üretmesi istenir.  Bu amaçla üretece `memory` isimlendirilmiş argümanıyla
verilen `Codifications::Memory` nesnesinden yararlanacaksınız.  Ön tanımlı
davranışta kod üreteci `Codifications::NilMemory` nesnesiyle hafızasız davranır.

```ruby
class Coder
  def initialize(seed, ends: nil, allowed: nil, memory: NilMemory.new)
    ...
  end
end
```

Geçmişi kaydeden basit sözlük türünde bir hafıza kullanabilirsiniz.  Bu amaçla
hazır `Codifications::SimpleMemory` nesnesini kullanabilirsiniz.

```ruby
memory = Codifications::SimpleMemory.new { '002' => true }
coder = Codifications::Coder.new '000', memory: memory
coder.generate #=> '000'
coder.generate #=> '001'
coder.generate #=> '003', '002' hatırlandı
```

`SimpleMemory` nesnesinin yeterli gelmediği durumlarda kendi hafıza nesnenizi
yazmak durumundasınız.  Hafıza nesneleri sadece iki metoda: `remember` ve
`remember?` cevap veren baist nesnelerdir;  `remember` metodu argüman olarak
verilen bir kod dizgisini saklar, `remember?` metodu ise argüman olarak verilen
bir kod dizgisinin hafızada olup olmadığını döner.

Örneğin tamamen veritabanından çalışan bir hafıza nesnesi oluşturmak isterseniz
aşağıdaki sınıf tanımını yapabilirsiniz.

```ruby
class DatabaseMemory < Codifications::Memory
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

Ön ekli kod üretimi
-------------------

Kod üretiminin özel bir hali olarak ön ekli kod üretmek için `PrefixedCoder`
sınıfı kullanılır.

```ruby
coder = PrefixedCoder.new '078', prefix: ['203', '19'] # veya prefix: '20319'
coder.generate #=> "20319078"
coder.generate #=> "20319079"

coder.next_sequence    #=> "080" (coder çekirdeğini değiştirmez)
coder.initial_sequence #=> "001"
```

Örnekte de görüldüğü gibi `PrefixedCoder` üreteci `prefix sequence`
biçiminde kodlar üretir.  Ön ekin tanımlandığı `prefix` seçeneği farklı
kaynaklardan gelen ön ekleri vurgulamak amacıyla dizi olarak verilebilir.

Başlangıç ardışımı argümanı `nil` verilirse ilk ardışım, ön ekler ve üreteç
uzunluğu dikkate alınarak otomatik hesaplanır.  Önerilen kullanım şekli de
böyledir.  Örneğin veritabanı gibi bir kaynaktan başlangıç ardışımını okurken bu
değeri `nil` olarak ayarlamanız üretecin sıfırlanması için yeterlidir.

```ruby
coder = PrefixedCoder.new nil, prefix: ['203', '19'] # veya prefix: '20319'
coder.generate #=> "20319001"
coder.generate #=> "20319002"

coder.next_sequence    #=> "003"
coder.initial_sequence #=> "001"
```

Üretilen kod öntanımlı olarak 8 hanedir.  Ön eklerin varlığı nedeniyle ardışımın
uzunluğu 8 değerinden çok daha küçüktür (yukarıdaki örnekte 3 hane).  Ardışım
için daha fazla sayıda haneye ihtiyacınız varsa `prefix` değerini ihtiyaç
duyulan hane sayısına göre daraltabilirsiniz.

```ruby
long_coder = PrefixedCoder.new '001', prefix: '203'

long_coder.generate #=> "20300001"
long_coder.generate #=> "20300002"

long_coder.next_sequence    #=> "00003"
long_coder.initial_sequence #=> "00001"
```

Daha uzun kodlar üretmek için miras alma yoluyla yeni bir sınıf
oluşturabilirsiniz.


```ruby
class CustomCoder < PrefixedCoder
  self.length = 12
end
```

Üretecin davranışını inşa zamanında vereceğiniz seçeneklerle değiştirerek çok
daha özel bir üreteç de gerçekleyebilirsiniz.  Örneğin aşağıdaki üreteç `0`
rakamı içermeyen kodlar üretmektedir.  Kullanılabilecek geçerli seçenekler için
`Coder` sınıfını inceleyin.


```ruby
never_zero_coder = PrefixedCoder.new nil, prefix: '203', deny: /0/
never_zero_coder.generate #=> "20311111"
```
