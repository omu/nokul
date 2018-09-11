Use Case: Ders ekle
============

**Story:** Admin olarak ilgili bölüme ders eklemek istiyorum.

**Actor:** Admin

**Preconditions:**

- Birimler tanımlanmış olmalı.
- İlgili birim için `Kod Ön Ek` bilgisi tanımlanmış olmalı.

**Actor:** Kullanıcı, “Ders Ekle” butonuna tıklar.
**System:** Sistem, kullanıcıya “Ders Ekle Formu” görüntüler.

**Actor:** Kullanıcı, formu doldurur ve “Kaydet” butonuna tıklar.
**System:** Sistem, kullanıcıya validasyon için emin misiniz diye sorar.

**Actor:** Kullanıcı validasyon sorusuna “Eminim” diye cevap verir.
**System:** Sistem, form verilerinde teorik + uygulama + laboratuvar saatleri
toplamı 0’dan büyük olmasını bekler. Bu toplam 0 ise, sistem hata mesajı
gösterir ve kayıt gerçekleşmez.

Sistemde, ilgili birime ait derslerin sahip olduğu kodlarla aynı olmayacak
şekilde, yeni ders için bir ders kodu üretir. Bu kod, birimin `Kod Ön Ek`
bilgisini de içerir. Örneğin; “BIL302”. Format: {KOD-ÖN-EK}{3 HANELİ BİRİM
İÇERİSİNDE TEKİL NO}

Sistem, ders kaydını tamamlar.

**Actor:** Bölüm kurul sorumlusu validasyon sorusuna “Emin değilim” diye cevap
verir.
**System:** Sistem hiçbirşey yapmaz. İlgili ekranı görüntülemeye devam
eder.

**Not:** Ders Ekle Formunda bulunması gereken alanlar:

- Birim -> Dropdown list (dl)
- Ders Adı -> input (i)
- Teorik, Uygulama, Laboratuvar (kredi bu değerlere göre hesaplanmalı)
- Eğitim türü -> Dropdown list (dl)
- Dil -> Dropdown list (dl) (diller modelinden gelmeli)
- Durum -> Dropdown list (dl) (aktif, pasif, arşiv)