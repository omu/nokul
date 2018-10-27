`Ruling`
========

`Ruling` modülü diziler üzerinden çalışan bir kural motorudur.  Kural motoru
`Ruling` isim uzayında üç ana sınıfla yönetilir: `Checker`, `Rule` ve
`Violation`.  Bunlardan `Checker` kural motorunu dizi üzerinden çalıştıran
yönetici sınıftır. Motorun ana bileşeni olan `Rule` kural yazmak için `Minitest`
benzeri hafif bir DSL sunar ve kaydı yapılan kuralları dizi üzerinde dolaşırken
her eleman için çalıştırır.  Doğrudan kullanılmayan `Violation` ise kural
ihlallerini temsil eden bir tip sınıfıdır.

```ruby
class NameSafeRule < Ruling::Rule
  synopsis 'İsimlerde güvensiz karakterler olmamalı'
  subject :name

  rule 'no Turkish character' do
    spot if name =~ /[şğüöçıĞÜŞÖÇİ]/
  end
end

names = %w[
  recai
  serhat
  hüseyin
  irfan
]

checker = Ruling::Checker.new names
violations = checker.check NameSafeRule

violations.size #=> 1
violations.first.detail #=> "Türkçe karakter içeriyor: hüseyin"
```

Örnekte görüldüğü öncelikle yapılması gereken `Ruling::Rule`'dan miras alan bir
kural sınıfı oluşturup `rule` DSL'yle ortak bir amaca hizmet eden bir veya daha
fazla sayıda kurallar yazmaktır.  Bu yapıldıktan sonra üzerinde çalışılacak olan
diziyle bir `Ruling::Checker` nesnesi oluşturulur ve dizi bir veya daha fazla
sayıda kural sınıfını argüman olarak vererek denetlenir.  `Checker` nesnesi dizi
üzerinde dolaşırken her seferinde kural sınıfı içinde `rule` ile kaydedilen
kuralları yazılış sırasıyla güncel dizi elemanı üzerinde uygular ve çalışması
tamamlandığında tespit edilen tüm kural ihlallerini temsil eden bir `Violation`
dizisi döner.

Dizi üzerinde dolaşırken kural blokları güncel dizi elemanını genel olarak
`subject` değişkeniyle tanır.  Dilerseniz güncel dizi elemanı kural sınıfı
içinde `subject :alternatif_isim` DSL'yle `subject` yerine `alternatif_isim`
olarak ayarlanabilir. Örnekte `names` dizisinin elemanları için `name` ismi daha
uygun olduğundan `subject :name` ile dizi elemanının `name` değişkeniyle temsil
edilmesi sağlanmıştır.

Kural sınıfının adı (örnekte `NameSafeRule`) ilgili kuralı (bir tür hata kodu
gibi) kodlayan kural kodu olarak işlev görür.  Kuralın metinsel açıklaması ise
`synopsis` DSL'yle ayarlanır.  Bu açıklama kural ihlallerinin raporlanmasında
kullanılmaktadır.  Kural sınıfının adlandırmasında herhangi bir kısıtlama
yoktur.  Fakat kural sınıf adında üzerinde çalışılan dizi elemanını temsil eden
bir ismin ön ek (örnekte `Name`) ve `Rule` kelimesinin son ek olarak
kullanılması tavsiye edilen pratiktir.

Kural metodu çalışırken kural ihlalleri `spot` metoduyla kayıtlanır.  **Kural
metodunun dönüş değerinin kural ihlali açısından hiç bir önemi yoktur.**  `spot`
metoduna isteğe bağlı argüman olarak verilen mesaj kural ihlali raporlanırken
kullanılmaktadır.  Argüman verilmezse kural ihlali kural adıyla öntanımlı olarak
eklenir.  Bir kural metodunda birden fazla `spot` çağrısı bulunabilir.  Ama
tavsiye ettiğimiz pratik her kural metodu için tek bir `spot` çağrısı
kullanmaktır.

Bir kural sınıfında birden fazla kural olabilir.  Kurallar sınıf içindeki
yazılış sırasıyla uygulanır ve öntanımlı davranış olarak ilk kural ihlalinde
diğer kurallar uygulanmadan bir sonraki elemana geçilir.

Örneğe bir ekleme daha yaparak boşluk karakterinin olmaması kuralını "güvenli
isim" kural kümesine ekleyelim.

```ruby
class NameSafeRule < Ruling::Rule
  synopsis 'İsimlerde güvensiz karakterler olmamalı'
  subject :name

  rule 'no Turkish character' do
    spot if name =~ /[şğüöçıĞÜŞÖÇİ]/
  end

  rule 'no space character' do
    spot if name =~ /\s/
  end
end

names = %w[
  recai
  serhat
  hüseyin
  irfan
]

names << 'ayşe begüm' # iki ihlal içeriyor: Türkçe karakter ve boşluk

checker = Ruling::Checker.new names
violations = checker.check NameSafeRule

violations.size #=> 2, dikkat! 3 değil, çünkü boşluk kuralına geçmedi
violations.first.detail #=> "Türkçe karakter içeriyor: hüseyin"
violations.second.detail #=> "Türkçe karakter içeriyor: ayşe begüm"
```

Kuralları buraya kadar basitleştirilerek anlattık.  Bir kuralın uygulanabilmesi
için güncel elemanı dışında bilgiler de gerekebilir.  Örneğin isim listesindeki
her ismin tekilliğini denetleyen "isimlerin tekil olması" kuralını formüle
edelim.  Açıktır ki böyle bir kuralı denetlemek için sadece güncel eleman
bilgisi yeterli gelmeyecek, ilave olarak bir de `context` adını verdiğimiz
bağlam bilgisi gerekecektir.  Listede dolaşırken bağlam (`context`) ortamına
gömeceğimiz bir başvuru tablosuyla (`context.seen`) ismin tekrarlanma durumunu
sınayabiliriz.


```ruby
class NameSafeRule < Ruling::Rule
  synopsis 'İsimlerde güvensiz karakterler olmamalı'
  subject :name

  def self.setup(context)
    context.seen = {}
  end

  rule 'no Turkish character' do
    spot if name =~ /[şğüöçıĞÜŞÖÇİ]/
  end

  rule 'no space character' do
    spot if name =~ /\s/
  end

  rule 'must be unique' do |context|
    spot if (seen = context.seen)[name]
    seen[name] = true
  end
end

names = %w[
  recai
  serhat
  hüseyin
  irfan
  recai
]

checker = Ruling::Checker.new names
violations = checker.check NameSafeRule
```

Bu örnekte `must be unique` kural bloğuna öncekilerden farklı olarak ekstra bir
`context` argümanı geçirildiğini görüyoruz.  `ActiveSupport::OrderedOptions`
türünde bir nesne olan `context` değişkeni isteğe bağlı olarak tüm kurallara
geçirilen bir bilgidir.  Yapılması gereken ilgili kural bloğunda bu değişkenin
argüman listesine yazılarak talep edilmesidir.

Liste dolaşımı süresince yaşayan bu değişken ilgili kurallar uygulanırken bir
tür genel değişken gibi davranır (ortam değişkenlerini tutan `ENV` gibi).  Yani
`subject` değişkeni her elemanda değişen bir bilgi iken `context` bilgisi liste
genelinde geçerli olan ve kural çalışırken ilgili kural metodu tarafından
bileşenleri mutasyona uğratılabilecek bir durum bilgisidir.  Bağlam
bilgilerindeki bir bağlam değişkeninin ilklenmesi liste üzerinde dolaşmaya
başlamadan önce çalıştırılan `setup` sınıf metodunda gerçekleşir.  Örnekte
`context.seen` bağlam değişkeninin liste dolaşımı başlamadan boş bir sözlük
olarak ilklendiği ve ilgili kuralda da güncellendiği görülüyor.

Bağlam değişkenlerini ilklemekte kullanılan `setup` sınıf metoduna ilave olarak
bağlam değişkenlerini her **dolaşım sonunda** değiştirmek için
kullanabileceğiniz bir `teardown` sınıf metodu da vardır.  Nadir durumlarda işe
yarayabilecek bu metodu belirli bir bağlam değişkenini sıfırlamak için
kullanabilirsiniz.

Kural nesnelerinin listedeki her eleman için o elemana gelindiğinde üretilen ve
kuralların o eleman için uygulanması tamamlandığında yaşam süresi sona eren PORO
nesneler olduğunu unutmayalım.  Dolayısıyla özellikle karmaşık kurallarda bir
kural sınıfına istediğiniz nesne metodunu veya nesne değişkenini
ekleyebilirsiniz.  Aşağıdaki kurgusal örnekte bu olanaktan yararlanıyoruz.

```ruby
class NameSafeRule < Ruling::Rule
  synopsis 'İsimlerde güvensiz karakterler olmamalı'
  subject :name

  VIOLATION_PATTERN = {
    'Türkçe karakter içeriyor' => /[şğüöçıĞÜŞÖÇİ]/,
     'Boşluk içeriyor'         => /\s/
  }.freeze

  def self.setup(context)
    context.seen = {}
  end

  rule 'no Turkish character' do
    spot_if 'Türkçe karakter içeriyor'
  end

  rule 'no space character' do
    spot_if 'Boşluk içeriyor'
  end

  rule 'must be unique' do |context|
    spot if (seen = context.seen)[name]
    seen[name] = true
  end

  protected

  def spot_if(message)
    spot "#{message}: #{name}" if name =~ VIOLATION_PATTERN[message]
  end
end
```

Kural sınıfları bir PORO olarak kullanıldığında bir nesne değişkenine ihtiyaç
duyarsanız ilklemek için `after_initialize` metodunu kullanabilirsiniz.  Bu
noktada yararlı olabilecek diğer iki metod da `before_rules` ve `after_rules`
metodlarıdır.  Her turun başında ve sonunda çalışan bu metodlarla nesne
değişkenlerini ilkleyebilir veya sıfırlayabilirsiniz.

```ruby
class NameSafeRule < Ruling::Rule
  synopsis 'İsimlerde güvensiz karakterler olmamalı'
  subject :name

  VIOLATION_PATTERN = {
    'Türkçe karakter içeriyor' => /[şğüöçıĞÜŞÖÇİ]/,
     'Boşluk içeriyor'         => /\s/
  }.freeze

  def self.setup(context)
    context.seen = {}
  end

  attr_accessor :number_of_applied_patterns

  def before_rules
    self.number_of_applied_patterns = 0
  end

  rule 'no Turkish character' do
    spot_if 'Türkçe karakter içeriyor'
  end

  rule 'no space character' do
    spot_if 'Boşluk içeriyor'
  end

  rule 'must be unique' do |context|
    spot if (seen = context.seen)[name]
    seen[name] = true
  end

  def after_rules
    puts "#{number_of_applied_patterns} sayıda desen uygulandı."
  end

  protected

  def spot_if(message)
    self.number_of_applied_patterns += 1
    spot "#{message}: #{name}" if name =~ VIOLATION_PATTERN[message]
  end
end
```

Kural motoru daima `Violation` dizisi döner.  Sadece kural ihlali mesajlarıyla
ilgileniyorsanız dizideki her elemanı `to_s` ile dizgiye çevirmeniz yeterlidir
(`puts` çağrılarında kendiliğinden gerçekleşen işlem.)

```ruby
checker = Ruling::Checker.new names
violations = checker.check NameSafeRule
violations.each do |violation|
  puts violation
end
```

Kural ihlaliyle ilgili yapısal bilgilere ihtiyacınız varsa `Violation`
nesnesinin niteliklerini kullanmalısınız.

- `rule`:Hangi kural ihlal edildi?  Kural sınıfı: ör. `NameSafeRule`
- `subject`: Dizide hangi elemanda kural ihlal edildi?
- `context`: Kural ihlali gerçekleştiğinde bağlam neydi?
- `detail`: Kural motorunun `spot` ile verdiği detay iletisi.
