---
author(s):
  - Recai Oktaş (@roktas)
---

Öğrencilerin Numaralandırılması
===============================

Kısaca USN (University Student Number) adı verilen öğrenci numaraları aşağıdaki
biçimde yazılan **10 haneli** numaralardır.

- Kısa sıra no:

        |-- Birim Kodu        --|--  Yıl  --|         Sıra        --|
              4 hane                2 hane           4 hane

        +-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
        |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  | 10  |
        |     |     |     |     |     |     |     |     |     |     |
        +-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+

- Uzun sıra no:

        |-- Birim Kodu        --|--            Sıra               --|
              4 hane                          6 hane

        +-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
        |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  | 10  |
        |     |     |     |     |     |     |     |     |     |     |
        +-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+

Sıra numarası her eğitim/öğretim yılında güncellenecek şekilde aşağıdaki
kurallara göre oluşturulur.

1. Öğrenci sıra numaraları kendisine ayrılan havuzda daima 1'den başlar.

2. Eski kayıtlanmalara bakıldığında programa bir eğitim/öğretimi dönemi içinde
   kayıtlanan öğrenci sayısının 9999'a yaklaşmadığı programlarda USN için sıra
   numarasının iki haneli eğitim/öğretim yılıyla başladığı "Kısa sıra no" biçimi
   kullanılır.

   Ör. Yıl içinde en fazla 150 yeni öğrencinin kayıtlandığı görülen 3456 birim
   numaralı Bilgisayar Mühendisliği Lisans programına 2020-2021 eğitim/öğretim
   yılında 42'nci sırada kayıtlanan öğrencinin numarası:

        3456200042

3. Yeni öğrenci sayısının 9999'u geçtiği **yeni** programlarda sıra numarasında
   yılın olmadığı "Uzun sıra no" biçimi kullanılır.

   Ör. Kayıtlanma döneminde toplamda 18000 yeni öğrencinin kayıtlandığı **yeni
   açılmış** 0123 birim numaralı İlahiyat Uzaktan Eğitim programına 12345'nci
   sırada kayıtlanan öğrencinin numarası:

        0123012345

4. Geçmişte kısa biçimin kullanıldığı **yeni olmayan** programlarda (çakışma
   çıkarabilecek eski öğrenci numaraları var) sıra numarası elverişli numara
   havuzundaki rakamların en düşüğüyle başlar ve kullanılan rakamlar atlanmak
   şartıyla doğrusal olarak arttırılır.

   Ör. 2020-2021 yılında açılmış 3456 kodlu programa 2023-2024 dönemine
   kadar her yıl 100 öğrenci kayıtlanmış (345620XXXX-345622XXXX numaraları mevcut).
   Buna göre 2023-2024 döneminde 19000 öğrenci kayıtlanacaksa numaralar 00001
   sıra numarasıyla başlar.  Bu öğrencilerden 12345'nci sırada kayıtlanan
   öğrencinin numarası:

        3456012345

5. Öğrenci numaralarında uzun biçime geçiş yapıldığında (öğrenci sayısının
   azalması dikkate alınarak) tekrar kısa biçime  dönüş yapılamaz.

Öğrenci numaralarının daima korunması tercih edilmekle birlikte numara
havuzlarının tükenmesi halinde zorunlu olarak sıfırlanabilir. Ör. (Teorik) 100
yıl sonra 2 haneli yıl alanının yetmemesi.
