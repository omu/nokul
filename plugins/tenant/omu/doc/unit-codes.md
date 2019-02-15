---
author: Recai Oktaş
---

Birimlerin Kodlanması
=====================

Üniversite birimlerinin kodlanması ÖSYM başta olmak üzere, YÖKSİS ve DETSİS'te
kayıtlı tüm birim ve programların internal olarak kodlanması anlamına
gelmektedir.  Birimler kabaca şu üç türde olabilir:

- Sadece ÖSYM ve YÖKSİS numarasına sahip eğitim programları.  Ör. Bilgisayar
  Mühendisliği Lisans/Önlisans programı (ÖSYM: `108210665`, YÖKSİS: `168861`)

- Sadece YÖKSİS numarasına sahip akademik birimler. Ör. Mühendislik Fakültesi
  (YÖKSİS: `122183`) veya Bilgisayar Araştırmaları Uygulama ve Araştırma Merkezi
  (YÖKSİS: `169403`)

- Sadece DETSİS numarasına sahip idari birimler.  Ör. Mühendislik Fakültesi
  Dekanlığı (DETSİS: `81181891`) veya Yazılım Talepleri Değerlendirme Komisyonu
  (DETSİS: `35354231`).

Belirtim bu üç türdeki tüm birimleri kısaca UUC (University Unit Code) adı
verilen **3 haneli** kodlarla temsil etmektedir.  Bu kodlar öncelikle iki alanda
kullanılacaktır:

- Kimliklendirme sisteminde (Hokul) birimlerin iç temsilinde kullanılacak

- (Dolaylı olarak) Google Suite üzerinde grupların oluşturulmasında kullanılacak

- Yeni öğrenci numaralarının ilk 3 hanesi "Örgün Eğitim" kısmında açıklanan
  birim numaraları olacak

**Ölçeklenebilir** bir olması hedeflenen bu belirtimde şu hususlar dikkate
alınmıştır:

- Yeni sisteme geçiş sürecinde karışıklık yaşanmaması için 2010-2019 arası
  dağıtılan ve 10-19 ile başlayan eski (legacy) numaralarla yeni numaraların
  çakışması engelleniyor.

- En ön planda olan eğitim/öğretim programları için sadece rakamlar tercih
  ediliyor.

- Önem sırasında ikinci olan akademik birimler için rakamlara ilave olarak
  (onaltılı sistemden esinlenen) ABCDEF harfleri kullanılıyor.

- Kalan tüm birimlerde ve rezerve amaçlı olarak diğer harflere de izin
  veriliyor: ABCDEFGHJKMNPRSTUVYZ.  Bu harflerin seçiminde:

  + Türkçe'ye özgü harfler: ÇĞÖŞÜ dışlandı

  + Türkçe'de bulunmayan harfler: QWX dışlandı

  + Yazımda karışabilecek harfler: ILO dışlandı

Eğitim Programları
------------------

1. hanede rakamlar: 0123456789 (10 adet) = 10 simge
2. hanede rakamlar: 0123456789 (10 adet) = 10 simge
3. hanede rakamlar: 0123456789 (10 adet) = 10 simge

| Başlangıç  | Bitiş       | Havuz       | Kullanım                     |
|:-----------|:------------|:------------|:-----------------------------|
| 001        | 099         | 99          | Uzaktan Eğitim programları   |
| 100        | 199         | 100         | Legacy rezerve               |
| 200        | 599         | 400         | Lisans ve ön lisans programı |
| 600        | 999         | 400         | Lisans üstü program          |

Akademik Birimler
-----------------

1. hanede harfler: ABCDEF (6 adet) = 6 simge
2. hanede rakamlar: 0123456789 (10 adet) + harfler: ABCDEF (6 adet) = 16 simge
3. hanede rakamlar: 0123456789 (10 adet) + harfler: ABCDEF (6 adet) = 16 simge

| Başlangıç  | Bitiş       | Havuz       | Kullanım                     |
|:-----------|:------------|:------------|:-----------------------------|
| A00        | FFF         | 1536        | Akademik birimler            |

İdari Birimler
--------------

1. hanede harfler: GH (2 adet) = 2 simge
2. hanede rakamlar: 0123456789 (10 adet) + harfler: ABCDEFGHJKMNPRSTUVYZ (20 adet) = 30 simge
3. hanede rakamlar: 0123456789 (10 adet) + harfler: ABCDEFGHJKMNPRSTUVYZ (20 adet) = 30 simge

| Başlangıç  | Bitiş       | Havuz       | Kullanım                     |
|:-----------|:------------|:------------|:-----------------------------|
| G00        | HZZ         | 1800        | İdari birimler               |

Özel Birimler
-------------

1. hanede harfler: Z (1 adet) = 1 simge
2. hanede rakamlar: 0123456789 (10 adet) + harfler: ABCDEFGHJKMNPRSTUVYZ (20 adet) = 30 simge
3. hanede rakamlar: 0123456789 (10 adet) + harfler: ABCDEFGHJKMNPRSTUVYZ (20 adet) = 30 simge

| Başlangıç  | Bitiş       | Havuz       | Kullanım                     |
|:-----------|:------------|:------------|:-----------------------------|
| Z00        | ZZZ         | 900         | Özel birimler                |

Genel Rezervasyon
-----------------

1. hanede harfler: JKLMNPRSTUVY (12 adet) = 12 simge
2. hanede rakamlar: 0123456789 (10 adet) + harfler: ABCDEFGHJKMNPRSTUVYZ (20 adet) = 30 simge
3. hanede rakamlar: 0123456789 (10 adet) + harfler: ABCDEFGHJKMNPRSTUVYZ (20 adet) = 30 simge

| Başlangıç  | Bitiş       | Havuz       | Kullanım                     |
|:-----------|:------------|:------------|:-----------------------------|
| J00        | ZZZ         | 9900        | Rezerve                      |

Buna ilave olarak:

- Legacy numaralar için ayrılan alan yeterince süre geçtiğinde örgün
  eğitim/öğretim için dolaşıma sunulabilir.

- Dışlanan tüm harfler (ILO QWX ÇĞÖŞÜ) aşamalı olarak dolaşıma sunulabilir.
