---
author(s):
  - Recai Oktaş (@roktas)
---

Kullanıcıların İsimlendirilmesi
===============================

Kullanıcı ismi **tercihen** tam adın ilk harfleri ve soyadın tamamının rastgele
üretilen 3 haneli bir son ekle birleştirilmesiyle oluşturulur.

        «İsimlerin ilk harfleri»«Soyad».«3 haneli rastgele sayı»

İsim şu koşulları sağlar:

1. Hepsi küçük harf
2. Türkçe karakterler ASCII eşdeğerleriyle değiştirilmiş
3. Eposta alanında (`@omu.edu.tr`) tekil
4. Uygun: son eksiz haliyle nahoş veya rezerve edilmiş bir kelime değil

Örnek:

| Ad           | Soyad       | Kullanıcı adı |
|--------------|-------------|---------------|
| Su           | Er          | ser.819       |
| Ahmet Fuat   | Yılmaz      | afyilmaz.058  |
| Merve        | Sağlam      | msaglam.140   |

Tek ilk ad ve soyad durumunda tercihen edilen biçimde üretilen bir isim 4
numaralı koşulu sağlamıyorsa aşağıdaki biçimde tekrar üretilerek koşullara
uygunluğu denetlenir.

        «İlk ad»«Soyadın ilk harfi».«3 haneli rastgele sayı»

Örnek:

| Ad           | Soyad       | Uygunsuz ad   | Uygun ad     |
|--------------|-------------|---------------|--------------|
| Suat         | Alak        | salak.123     | suata.123    |
| Dilek        | Ay          | day.378       | dileka.378   |

İsim bu haliyle de uygun değilse kısaltılmadan yazılır.

Birden fazla ilk ad ve soyad durumunda, "Mustafa Kemal Atatürk" ile
örneklenecek olursa tercih sırasıyla aşağıdaki isimler denenir.

        mkataturk
        mkemala
        mustafaka
        mkemalataturk
        mustafakataturk
        mustafakemala
        mustafakemalataturk

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
