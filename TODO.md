# TODO List

## Location, Unit ve Program

- [ ] Universiteyi'de Unit altına al.
- [ ] Modeller için testler yazılacak.
- [ ] Program modeline ve yöksis data parser'ına öğrenim türü alanı eklenecek.
- [ ] Program modelinde language alanı çalışır hale gelecek, enumeration eklenecek.
- [ ] Location, Unit ve Program modellerinde name alanı upcase yapılırken ı ve i'lerde sorun var.
- [ ] YOKSIS birim datası ile, sistemi senkron tutan bir worker/background job yazılacak.

## YOKSIS API

- [ ] YÖKSİS'ten gelen dataya ne kadar güvenebilir ve bu dataya güvenerek kendi datamızı güncelleyebiliriz? Otomatik güncel tutma işi sakat gibi?
- [ ] Servisler için error handling yapılacak. Tek bir mekanizma tümünde geçerli olmalı.
- [ ] SHA1 hesaplatırken, error mesajı dönme ihtimalini görüp, bunların hashing'e sokmamak lazım.
- [ ] YOKSISV4 Universite birimler API'ına ilişkin task'lar hazırlanacak. Bunun da rake task olarak otomatik güncellenmesi söz konusu olmalı. Departments.rake tasks/yoksis altına taşınacak.
- [ ] YOKSIS ünvanlar için de aynısını yap.
- [ ] Bu taskler için :all tanımlayarak her gece 02am'de çalışmalarını sağla.

## User

- [ ] Bir kişi aynı anda hem hocam, hem memur hem de öğrenci olabilir.
- [ ] Tüm User'ların mernis'ten gelen kimlik bilgileri, adres bilgileri ve temel bilgileri sınav sonuç bilgilerini tutmak faydalı olabilir.
- [ ] Akademisyenin ek olarak ünvan olayı var.
- [ ] Öğrencinin ek olarak bölüme enrollment olayı var.
- [ ] Tüm personeli yöksis'ten alıp import etsek?
- [ ] Tüm öğrencileri ubs'den alıp import etsek?