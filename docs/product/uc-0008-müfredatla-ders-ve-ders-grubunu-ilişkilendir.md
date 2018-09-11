Use Case: Müfredatla ders ve ders grubunu ilişkilendir
============

**Story:** Admin olarak daha önce oluşturmuş olduğum müfredatla ders veya ders grubunu ilişkilendirmek istiyorum.

**Actor:** Admin

**Preconditions:**

- Birimler tanımlanmış olmalı
- Programlar tanımlanmış olmalı
- Tanımlı programlar arasında hazırlık programları belirtilmiş olmalı
- Senotaya ait kurul/komisyon kararlarına erişilebilir olmalı
- Daha önceden tanımlanmış en az 1 müfredat olmalı

| Actor        | System       |
| :----------- |:-------------|
| Kullanıcı ders veya ders grubu eklemek istediği müfredatı seçer.| Sistem, kullanıcıya ilgili müfredata ait yarıyılları gösterir.|
| Kullanıcı ders eklemek istediği yarıyıla gelerek “ders ekle” veya “ders grubu ekle” seçimini yapar.| Sistem kullanıcıya “Var olan derslerden seç” ve “Yeni Ders oluştur” seçeneklerini gösterir.|
| Kullanıcı “Var olan derslerden seç” seçimini yapar.| Sistem ilgili birim için oluşturulmuş veya bu birim ile paylaşımda olan dersleri listeler.|
| Kullanıcı listeli derslerden seçim yapar ve ekle butonuna tıklar.| Sistem seçili dersi ilgili yarıyıla ekleyerek bilgileri günceller.|
| Kullanıcı “Yeni Ders oluştur” seçimini yapar.| Sistem kullanıcıya yeni ders oluşturma formunu gösterir.|
| Kullanıcı ders oluşturma formunu doldurarak kaydet butonuna tıklar.| Sistem ders ile ilgili kontrolleri yaparak dersi kaydeder ve dersi ilgili yarıyıla ekler.|
| Kullanıcı ders veya ders grubu eklemek istediği yarıyıla gelerek “ders ekle” seçimini yapar.| Sistem kullanıcıya “Var olan ders gruplarından seç” ve “Yeni Ders Grubu oluştur” seçeneklerini gösterir.|
| Kullanıcı “Var olan ders gruplarından seç” seçimini yapar.| Sistem ilgili birim için oluşturulmuş veya bu birim ile paylaşımda olan ders gruplarını listeler.|
| Kullanıcı listeli ders gruplarından seçim yapar ve ekle butonuna tıklar.| Sistem seçili ders grubunu ilgili yarıyıla ekleyerek bilgileri günceller.|
| Kullanıcı “Yeni Ders Grubu oluştur” seçimini yapar.| Sistem kullanıcıya yeni ders grubu oluşturma formunu gösterir.|
| Kullanıcı ders grubu oluşturma formunu doldurarak kaydet butonuna tıklar.| Sistem ders grubu ile ilgili kontrolleri yaparak ders grubunu kaydeder ve ders grubunu ilgili yarıyıla ekler.|