Use Case: Aday Öğrencileri Listele
============

**Story:** Admin olarak aday öğrencileri listelemek istiyorum.

**Actor:** Admin

**Preconditions:**

- Üniversitemizin herhangi bir bölümünü kazanmış adayları, yıl bilgileri ve aday
  oldukları bölüm bilgileri ile birlikte sistemdeki bölüm aday listesine
  aktarılmış olmalı.

**Postconditions:**

- Adaylar listelenmeli.
- Adaylar yıllara, bölüme, ada, soyada, TC’ye göre filtrelenebilmeli.

| Actor        | System       |
| :----------- |:-------------|
| Kullanıcı, “Aday Listesi” menüsüne tıklar. | Sistem, içerisinde bulunulan yıldaki bölüm adaylarını listeler.|
| Kullanıcı, arama alanındaki anahtar kelime kısmına ad, soyad, bölüm ya da TC bilgisi girer; ayrıca isterse arama alanındaki yıl alanında bir yıl seçer ve ara butonuna tıklar.| Sistem, girilen anahtar kelimeyi, bölüm adayları listesindeki kayıtların ad, soyad, bölüm ve TC alanlarında, gönderilen yıl bilgisiyle filtreleyerek arar ve sonuçları listeler.|

![alt text](assets/mockups/kayit/1.png)