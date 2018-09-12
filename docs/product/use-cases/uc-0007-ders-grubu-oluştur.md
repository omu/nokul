---
story: Admin olarak, daha önce oluşturulmuş dersleri gruplayarak seçmeli ders grubu oluşturmak istiyorum
actor: Admin
---

Use Case: Ders grubu oluştur
============

**Preconditions:**

- Birimler tanımlanmış olmalı
- Programlar tanımlanmış olmalı
- Tanımlı programlar arasında hazırlık programları belirtilmiş olmalı
- Senotaya ait kurul/komisyon kararlarına erişilebilir olmalı
- Dersler tanımlanmış olmalı

| Actor        | System       |
| :----------- |:-------------|
| Kullanıcı, “Ders Grubu Oluştur” butonuna tıklar.| Sistem kullanıcıya ders grubu oluşturma formunu gösterir.|
| Kullanıcı formda istenen bilgileri doldurur.| Sistem, kullanıcıya formda belirtilen birime ait veya bu birim ile paylaşılan dersleri listeler.|
| Kullanıcı listelenen derslerden gruplanacak olanları seçer ve "Kaydet" butonuna tıklar.| Sistem varsa grup koşullarının seçim yapılan dersler ile sağlanıp sağlanamadığını kontrol eder. <br><br> Koşullar sağlanabiliyor ise sistem ilgili ders grubunu oluşturur.<br><br> Koşullar sağlanamıyor ise hata mesajı döndürür.<br><br> Örnek kontrol-1: Ders grubunda bulunan toplam AKTS değerinin koşul olarak verilen min AKTS değerinden büyük olması gerekir. <br><br> Örnek kontrol-2: Ders grubunda yer alan ders sayısının koşul olarak verilen min ders sayısından büyük olması gerekir.|

**Ders Grubu Formu:**

- Ders Grubu Adı
- Ders Grubu Birimi
- Paylaşılan Birimler
- Ders Grubu Koşulları
  * Min AKTS
  * Min Ders Sayısı
- Ders Grubu Tipi
  * Sosyal Seçmeli
  * Bölüm Seçmeli
  * Üniversite Seçmeli
  * …

**Ders Listesi:**

- Ders Grubu oluşturulan birim için tanımlanan dersler
- Ders Grubu oluşturulan birim ile paylaşılan dersler
