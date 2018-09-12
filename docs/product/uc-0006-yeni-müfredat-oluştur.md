Use Case: Yeni müfredat oluştur
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
| Kullanıcı, “Yeni Müfredat Oluştur” butonuna tıklar.| Sistem, kullanıcıya “Müfredat Ekle Formu” görüntüler.|
| Kullanıcı, formu doldurur ve “Kaydet” butonuna tıklar.| Sistem, formdaki alanları kontrol ederek ilgili kaydı gerçekleştirir. |
|| Sistem kayıtlı müfredatları listeleme ekranına döner.|

**Not:** Yeni Müfredat Oluştur Formunda bulunması gereken alanlar:

- Müfredat adı
- Birimi
- Yarıyıl sayısı
- İlk uygulandığı yıl ve dönem
- Kaldırılma yıl ve dönem
- Senato kararı
- İlgili birimler