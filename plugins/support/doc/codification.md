---
author: Recai Oktaş
---

`Codification`
==============

`Codification` modülü entitelere kod ataması yapmakta kullanılan sınıflardan
oluşmaktadır.  Temelde bir
[`Enumerator`](https://ruby-doc.org/core-2.6.2/Enumerator.html) nesnesi olan
`Code` verilen bir "kaynağı" bir `Enumerator"e çevirir ("take_in") ve her
ardışımda bir String dizisi yayımlar ("take_out").  Yayımlanan String dizisi
seçenek olarak verilen ön ek, son ek ve ara ekler dikkate alınarak nihai "kod"
olan String'e çevrilir.

Üretilen kodun tekilliğine ve uygunluğuna (ör. ofensif olup olmaması) `Coder`
nesnesi  karar verir.  Tekillik denetimi `Memory` nesnesi üzerinden, uygunluk
denetimi ve son işleme (ör. rastgele son ek ekle) `Processor` nesnesi üzerinden
gerçekleşir.

Tüm kodlama gerçeklemeleri `codes` dizini altında basit bir eklenti düzeninde
tutulur.  Bu düzen içinde her kodlama türü aslında `Code` ve/veya `Coder`
nesnelerini özelleştirilmesinden ibarettir.

`Code`
------

Kodlama `Code` nesneleri üzerinden yürütülür.  Öncelikle soyut bir sınıf olan
`Code` sınıfından miras alma yoluyla somut bir sınıf oluşturulur.  Somut
sınıflar `take_in` ve `take_out` metodlarını gerçeklemelidir.

- `take_in` inşa zamanında verilen bir kaynağı (`to_enum` yoluyla) `Enumerator`
  yapılabilir bir forma dönüştürür.

- `take_out` dizgi temsili alınırken içteki `Enumerator` nesnesinden (`next`
  veya `peek` yoluyla gelen) değeri dönüştürür.

Aşağıda görülen `SimpleCode` bir dizgi dizisinden kod üretmeye yarayan somut bir
sınıf örneğidir.

```ruby
class SimpleCode < Code
  protected

  def take_in(value)
    value.must_be_any_of! [String]
  end

  def take_out(value)
    value
  end
end

```

Bu sınıf üzerinden örnekleme yapalım.

```ruby
code = Codification::SimpleCode.new %w[foo bar baz]
```

Gerçeklemede bir `Enumerator` barındıran bu Code nesnesi aşağıdaki davranışları
sergiler.

- Bir sonraki kod nesnesini `next` ile üretir.

  ```ruby
  code.next #=> 'bar'
  ```

- Bir sonraki kod nesnesinin ne olacağını (herhangi bir durum değişikliğine
  uğramadan) `peek` ile döner.

  ```ruby
  code.peek #=> 'baz'
  ```

- Başlangıç durumuna `rewind` ile geri döner.

  ```ruby
  code.rewind
  code.next #=> 'foo'
  ```

`Coder`
-------

Kodlama, inşa zamanında bir `Code` nesnesi alan `Coder` nesneleriyle yürütülür.
Kodlama sürecinde üretilen kodun her seferinde tekillik ve uygunluk denetimi
yapılır.

```ruby
memory = SimpleMemory.new
memory.remember 'bar'

coder = Codification::Coder.new SimpleCode.new(%w[foo bar baz]), memory: memory
coder.run #=> 'foo'
coder.run #=> 'baz' -- 'bar' bellekte
coder.run #=> StopIteration
```

`Code` nesnesi ardışımlar tükendiğinde `StopIteration` istisnası ürettiğinden
yukarıda örneklenen işlemi `loop` döngüsüyle de gerçekleyebilirsiniz

```ruby
memory = SimpleMemory.new
memory.remember 'bar'

coder = Codification::Coder.new SimpleCode.new(%w[foo bar baz]), memory: memory

produced = []
loop do
  produced << coder.run
end

produced #=> ['foo', 'baz']
```

`Processor`
-----------

`Coder` nesnesi üretilen kodları filtrelemek veya dönüştürmek için
`post_process` isimli bir seçenek kabul eder.  Bu seçenek içteki `Processor`
nesnesinin inşa edilmesinde kullanılmaktadır.

```ruby
memory = SimpleMemory.new
memory.remember 'bar'

custom_process = proc do |string|
  Processor.skip string, string != 'baz'
end

coder = Coder.new SimpleCode.new(%w[foo bar baz]), memory: memory, post_process: custom_process

produced = []
loop do
  produced << coder.run
end

produced #=> ['foo']
```

Bu örnekte `bar` değeri tekil olmadığından, `baz` değeri ise son işlemede
filtrelendiğinden atlanmış ve sadece `foo` değeri üretilmiştir.  Örnekte olduğu
gibi son işlemede kodu reddetmek için `Processor.skip` metodu kullanılır.
İkinci argümanda verilen ifade (`string != 'baz')  doğru ise kod kabul edilmekte
aksi halde reddedilmektedir.

Son işlemede tanımlanan `Proc` bloğunun ürettiği değer üretilen kod olarak kabul
edilmekte ve sonrasında tekillik denetimi yapılmaktadır.  Bu sayede sadece kod
kabulü değil kodun metinsel değişime uğratılması işlemi de gerçekleştirilebilir.

```ruby
memory = SimpleMemory.new
memory.remember 'bar.xxx'

custom_process = proc { |string| string + '.xxx' }

coder = Coder.new SimpleCode.new(%w[foo bar baz]), memory: memory, post_process: custom_process

produced = []
loop do
  produced << coder.run
end

produced #=> ['foo.xxx', 'baz.xxx']
```

Son işleme seçeneğinde özel `Proc` blokları yerine iki farklı forma daha izin
verilir.

- Seçenekte herhangi bir değer sembol tipindeyse `Processor` sınıfında
  tanımlanan yerleşik işleyicilerden birisiyle eşleştirilir.

  ```ruby
  coder = Coder.new SimpleCode.new(%w[foo salak baz]), post_process: :safe?

  produced = []
  loop do
    produced << coder.run
  end

  produced #=> ['foo', 'baz']
  ```

  Yerleşik işleyiciler için `Processor` sınıfını inceleyin.

- Seçenekte herhangi bir değer düzenli ifade tipindeyse, düzenli ifade kod
  uygunluğu için koşul kabul edilir.

  ```ruby
  coder = Coder.new SimpleCode.new(%w[foo bar baz]), post_process: /^b/

  produced = []
  loop do
    produced << coder.run
  end

  produced #=> ['bar', 'baz']
  ```

Son olarak son işleme seçeneğinde dizi de kullanılabileceğini belirtelim.
Seçenek dizi olarak tanımlanırsa son işleme dizideki sırayla gerçekleşir.

```ruby
coder = Coder.new SimpleCode.new(%w[foo bar baz]), post_process: [
  /^b/,
  proc { |string| string + '.xxx' }
]

produced = []
loop do
  produced << coder.run
end

produced #=> ['bar.xxx', 'baz.xxx']
```

`Memory`
--------

Kodun tekilliğinin denetlenmesinde `Memory` nesneleri kullanılır.  `Memory`
soyut sınıfından miras alan somut `Memory` nesnelerinde aşağıdaki metodlar
gerçeklenmiş olmalıdır.

- `remember(string, **options)?`: Verilen dizginin bellekte bulunup
  bulunmadığını döner.

- `remember(string, **options)`: Verilen dizgiyi belleğe kaydeder.

- `forget(string, **options)`: Verilen dizgiyi bellekten siler.

Bu metodlara ilave olarak tüm metodlarda bulunan ve gerçeklenmesi gerekmeyen
yardımcı bir metod daha bulunmaktadır: `learn(string, **options)`.  Bu metod:

- Verilen dizgi bellekteyse nil döner.

- Bellekte değilse belleğe kaydeder ve dizgiyi geri döner.

Yerleşik kodlamalar
-------------------

Özel bir kodlama hazırlamak yerine `codes` altında tanımlı yerleşik kodlama
modüllerini kullanabilirsiniz.

- `random_numeric_codes`: Verilen aralıkta rastgele numerik kodlar üretir.

  ```ruby
  coder = Codification.random_numeric_codes '00003'..'00099', prefix: '203'
  coder.run #=> '20300023' (ilgili aralıkta rastgele)
  ```

- `sequential_numeric_codes`: Verilen aralıkta ardışık numerik kodlar üretir.

  ```ruby
  coder = Codification.sequential_numeric_codes '00003'..'00099', prefix: '203'
  coder.run #=> '20300003'
  coder.run #=> '20300004'
  ```

- `suffixed_user_names`: Verilen isimlerden rastgele son ekli ve güvenli
  kullanıcı adları üretir.

  ```ruby
  coder = Codification.suffixed_user_names %w[mustafa kemal atatürk]
  coder.run #=> 'mkataturk.123' (son ek rastgele)
  ```

- `unsuffixed_user_names`: Verilen isimlerden son eksiz ve güvenli kullanıcı
  adları üretir.

  ```ruby
  coder = Codification.unsuffixed_user_names %w[mustafa kemal atatürk]
  coder.run #=> 'mkataturk'
  coder.run #=> 'mkemala'
  coder.run #=> 'mustafaka'
  coder.run #=> 'mkemalataturk'
  coder.run #=> 'mustafakataturk'
  coder.run #=> 'mustafakemala'
  coder.run #=> 'mustafakemalataturk'
  ```

Yeni bir yerleşik kodlama hazırlamak isterseniz `codes` dizini altında uygun
şekilde isimlendirilmiş bir modül oluşturun.  Örneğin `SimpleCodes` isimli bir
modülü ele alalım.  `codes/simple_codes.rb` dosyasını aşağıdaki şablonda
oluşturun ve modül adını (`SimpleCodes`) `codes.rb`'de kaydedin.

```ruby
module Nokul
  module Support
    module Codification
      module SimpleCodes
        class Code < Codification::Code
          # custom code
        end

        class Coder < Codification::Coder
          # custom coder
        end
      end
    end
  end
end
```

Bu noktadan sonra kodlamayı jeneratör olarak (çoğul formda) `simple_codes`
adıyla, tek üretim için (tekil formda) `simple_code` adıyla kullanabilirsiniz.
