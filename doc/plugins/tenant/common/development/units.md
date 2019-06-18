---
author(s):
  - Recai Oktaş (@roktas)
---

`Nokul::Tenant::Units`
======================

Kiracı birimlerine ait statik verileri yöneten modül.

Kiracıya ait birim bilgileri ilgili kiracı eklentisinin kökünde `db/units`
dizini altında kayıtlıdır.  Birim bilgileri YÖKSİS (akademik birimler), DETSİS
(idari birimler) olarak 2 farklı kaynaktan, `Raw` ve `Src` şeklinde 2 farklı
biçimde kayıtlıdır.

`Raw` biçimi birim verilerini Xokul API'den aldığı haliyle dokunmadan koruyan
biçimdir.  Bu biçimdeki veriler `db/units/raw` dizini altında aşağıdaki düzende
kayıtlıdır.

- `raw/det.yml`: DETSİS birimleri

- `raw/yok.yml`: YÖKSİS birimleri

`Src` biçimi birim verilerinin editör tarafından kolayca düzenlenebilmesini ve
daha sonra bu verilerin veritabanına "seed" edilebilmesini sağlayacak biçimdir.
Bu biçimdeki veriler `db/units/src` dizini altında aşağıdaki düzende kayıtlıdır.

- `src/det.yml`: DETSİS birimleri

- `src/yok.yml`: YÖKSİS birimleri

(Dizinde bu iki dosyaya ilave olarak bulunan dosyalar aşağıda değinilmiştir.)

Editör yukarıda listelenen `Src` dosyalar üzerinde çalışarak aşağıdaki işlemleri
gerçekleştirir.

- Aktif veya (kapatıldığı halde hala öğrencisi olan) Yarı Pasif tüm birimler
  için kısaltma oluşturur.

- DETSİS birimlerini YÖKSİS ağacında seçilen ata birimlerle ilişkilendirir.

- Birim bilgilerinde sorunlar varsa `issues` altında bu sorunları listeler.

- Varsa bazı eksik bilgileri, örneğin `district_id` bilgilerini girer.

Düzenlemeler tamamlandıktan sonra bu iki dosyadan nihai olarak veritabanına
"seed" edilecek "birleştirilmiş birim verileri" `src/all.yml` dosyasında
oluşturulur.  Birleştirme sırasında aşağıda listelenen işlemler
gerçekleştirilir:

- Tüm birimler için 3 haneli tekil kodlar üretilir.

- Artık iç içe geçmiş olan YÖKSİS ve DETSİS ağaçları tek bir ağaç halinde atadan
  çocuğa doğru sıralanır.

**Uygulama açısından bakıldığında muhatap alınacak temel dosya birleştirilmiş
`db/units/src/all.yml` dosyasıdır.**  Dosya kesinlikle elle düzenlenmez ve
birimler daima ağaç sırasıyla (atadan çocuğa) kayıtlıdır.

Birleştirilmiş birim verilerine erişmek için aşağıdaki örnek kod kullanılır.

```ruby
units = Nokul::Tenant::Units.load_source 'src/all'
```

Bu şekilde elde edilen `units` temelde bir Ruby `Set` nesnesidir.  Birimlerde
tekrarlı veri bulunmaz ve `Set` sınıfındaki metodlar kullanılabilir.  Örneğin
birimleri birim tipine göre sınıflayalım.

```ruby
units.classify(&:unit_type_id).each do |type, classified_units|
  puts type
  puts '---'
  puts

  classified_units.each do |unit|
    puts unit.name
  end

  puts
end
```

YÖKSİS numarasını bildiğiniz bir birimi `units` kolleksiyonundan çekmek için
`get` metodunu kullanabilirsiniz (bizim eklediğimiz özel bir metod).

```ruby
puts units.get('123456').unit_type_id
```

Benzer işlem DETSİS birimleri için de DETSİS numaraları üzerinden
gerçekleştirilebilir.

Birim Düzenlemeleri
-------------------

Aşağıda listelenen durumlar birleştirilmiş birim verilerinde doğrudan veya
dolaylı olarak değişikliğe yol açar.

1. `plugins` altındaki eklentilerde gerçekleşen her türlü kod değişikliği (birim
   verilerinde dolaylı olarak değişikliğe yol açabilir)

2. `Src` dosyalarda, örneğin `plugins/tenant/omu/db/units/src` dizini altındaki
    dosyalarda yapılan değişiklikler (birim verilerinde doğrudan değişikliğe yol
    açabilir)

Bu iki durumdan en az bir tanesi gerçekleşmişse birleştirilmiş birim verilerini
yeniden üretmeniz ve sonucu test etmeniz gerekir.  Bu amaçla aşağıdaki yol
izlenmelidir.

```sh
cd plugins/tenant/omu
bundle install # henüz yapılmamışsa
bin/rails tenant:units:reproduce
bin/rails test
```
