---
author: Recai Oktaş
---

Kullanıcıların İsimlendirmesi
=============================

Kullanıcı ismi tam adın ilk harfleri ve soyadın tamamının kişinin TC kimlik
numarasından türetilen ve nokta ile başlayan 4 haneli bir son ekle
birleştirilmesiyle oluşturulur.  TC kimlikten türetiminde numaranın `10_000`
modu kullanılır ve bu şekilde elde edilen sayı 4 haneyi bulacak şekilde soldan
sıfırlarla doldurulur.

        «İsimlerin ilk harfleri»«Soyad».«TC kimlik no % 10_000»

İsim şu koşulları sağlar:

- Eposta alanında (`@omu.edu.tr`) tekil
- Hepsi küçük harf
- Türkçe karakterler ASCII eşdeğerleriyle değiştirilmiş

Örnek:

| Ad           | Soyad       | TC kimlik   | Kullanıcı adı |
|--------------|-------------|-------------|---------------|
| Su           | Ay          | 10570898198 | say.8198      |
| Ahmet Fuat   | Yılmaz      | 20047578058 | afyilmaz.8058 |
| Merve        | Sağlam      | 30097240140 | msaglam.0140  |

İsim çakışmaları TC kimlik numarasından türetilen son ekin tekillik sağlanıncaya
kadar arttırılmasıyla çözülür.  Örneğin bir kullanıcı için üretilen
`msaglam.0140` ismi geçmişte kullanılmışsa son ek arttırılarak `msaglam.0141`
ismi denenir ve arttırma çakışma olmayıncaya kadar devam eder.

Politika
--------

- Öğrenci ve personel isimleri arasında ayrım yapılmaz.  Tüm isimler
  `@omu.edu.tr` alanında tekil olacak şekilde aynı biçimde üretilir.
  (`@omu.edu.tr` alanında sadece gerçek kullanıcı adlarının değil tüzel kişi,
  grup adı vb isimlerin de bulunduğunu unutmayın.  Bazı isimler aktif şekilde
  kullanılmasa bile rezerve edilmiş olabilir.)

- Geçmişte kullanılan bir isim her ne nedenle olursa olsun asla tekrar
  kullanılmaz.

- Öğrencilere ait kullanıcı adlarında değişiklik talep edilemez.

- Personel kullanıcı adında değişiklik talep edebilir.

İsim değişiklikleri
-------------------

İsim değişiklikleri olabildiğince self servis yoluyla karşılanır.  Bu serviste
aşağıdaki ilkelere uyulmalıdır.

- Yeni isim önerisini kullanıcı serbest halde giremez; kendisine sunulan
  seçenekler arasında bir seçim yapar.

- Otomatik isim önerileriyle karşılanamayan durumlarda talepler BAUM'a
  iletilerek sistem yöneticileri tarafından karşılanır.

- İsim değişikliği gerçekleştiğinde eski isimler daima "alias" olarak korunur.
