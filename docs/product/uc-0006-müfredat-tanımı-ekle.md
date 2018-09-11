Use Case: Müfredat tanımı ekle
============

**Story:** Admin olarak, birimlerle ilişkili olarak müfredat tanımı eklemek istiyorum.

**Actor:** Admin

**Preconditions:**

- Birimler tanımlanmış olmalı
- Programlar tanımlanmış olmalı
- Tanımlı programlar arasında hazırlık programları belirtilmiş olmalı
- Senotaya ait kurul/komisyon kararlarına erişilebilir olmalı

| Actor        | System       |
| :----------- |:-------------|
| Kullanıcı, “Müfredat Ekle” butonuna tıklar.| Sistem, kullanıcıya “Müfredat Ekle Formu” görüntüler.|
| Kullanıcı, formu doldurur ve “Kaydet” butonuna tıklar.| Sistem, kullanıcıya validasyon için emin misiniz diye sorar. |
| Kullanıcı validasyon sorusuna “Eminim” diye cevap verir.| Sistem, öncelikle müfredat program türünü kontrol eder. Eğer müfredat program türü lisanssa, her dönemdeki zorunlu derslerin toplam AKTS değeri 30 olmalı. Aksi halde hata mesajı gönderir ve kayıt işlemini tamamlamaz. |
|| Müfredat ilgili birimle ilişkili olarak kaydedilir.|
| Kullanıcı validasyon sorusuna “Emin değilim” diye cevap verir.| Sistem hiçbirşey yapmaz. İlgili ekranı görüntülemeye devam eder.|

**Not:** Müfredat Ekle Formunda bulunması gereken alanlar:

- Müfredat adı
- Müfredat sahibi
- İlişkili programlar
- Kaç yarıyıllık