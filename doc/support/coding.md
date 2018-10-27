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
