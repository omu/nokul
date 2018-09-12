Use Case: Ders ekle
============

**Story:** Admin olarak ilgili bölüme ders eklemek istiyorum.

**Actor:** Admin

**Preconditions:**

- Birimler tanımlanmış olmalı.
- İlgili birim için `Kod Ön Ek` bilgisi tanımlanmış olmalı.

| Actor        | System       |
| :----------- |:-------------|
| Kullanıcı, “Ders Ekle” butonuna tıklar. | Sistem, kullanıcıya “Ders Ekle Formu” görüntüler.|
| Kullanıcı, formu doldurur ve “Kaydet” butonuna tıklar. | Sistem form verilerinde teorik, uygulama ve laboratuvar saatleri toplamının 0’dan büyük olmasını bekler (T+U+L>0). Bu toplam 0 ise, sistem hata mesajı gösterir ve kayıt gerçekleşmez. <br><br> Sistemde, ilgili birime ait derslerin sahip olduğu kodlarla aynı olmayacak şekilde, yeni ders için bir ders kodu üretir. Bu kod, birimin `Kod Ön Ek` bilgisini de içerir. Örneğin; “BIL302”. Format: {KOD-ÖN-EK}{3 HANELİ BİRİM İÇERİSİNDE TEKİL NO}. (Otomatik üretilen ders kodu kullanılabileceği gibi manuel de girilebilmeli. Ancak ders kodu tekil olmalı.)<br><br> Sistem, ders kaydını tamamlar. |
| Bölüm kurul sorumlusu validasyon sorusuna “Emin değilim” diye cevap verir. | Sistem hiçbir şey yapmaz. İlgili ekranı görüntülemeye devam eder.|

**Not:** Ders Ekle Formunda bulunması gereken alanlar:

- Birim -> Dropdown list (dl)
- Ders Adı -> input (i)
- Teorik, Uygulama, Laboratuvar (kredi bu değerlere göre hesaplanmalı)
- Eğitim türü -> Dropdown list (dl)
- Dil -> Dropdown list (dl) (diller modelinden gelmeli)
- Durum -> Dropdown list (dl) (aktif, pasif, arşiv)