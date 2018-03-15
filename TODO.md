# TODO List

## Location, Unit ve Program

- [ ] Modeller için testler yazılacak.
- [ ] YOKSIS birim datası ile, sistemi senkron tutan bir rake task worker/background job olarak yazılacak.

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