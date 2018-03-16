# TODO List

## Location, Unit ve Program

- [ ] Modeller için testler yazılacak.

## YOKSIS API

- [ ] Servisler için error handling yapılacak. Tek bir mekanizma tümünde geçerli olmalı.
- [ ] SHA1 hesaplatırken, error mesajı dönme ihtimalini görüp, bunların hashing'e sokmamak lazım.
- [ ] YOKSIS ünvanlar için de aynısını yap.
- [ ] Bu taskler için :all tanımlayarak her gece 02am'de çalışmalarını sağla.

## User

- [ ] User'ların sınav sonuçlarını da tutmak faydalı olabilir.
- [ ] Akademisyenin ek olarak ünvan olayı var.
- [ ] Öğrencinin bölüme enrollment olayı var. Birden çok bölüme enroll durumunda da olabilir. Hemde öğrenci, yatay, dikey, çap, yandal vs. olarak.
- [ ] Hocaların bölümde görevlendirilmesi olayı var.
- [ ] Tüm personeli yöksis'ten alıp import etsek?
- [ ] Tüm öğrencileri ubs'den alıp import etsek?
- [ ] User'daki KPS callback'leri background job olarak tasarlanacak. Error handling yapılacak, KPS'te sıkıntı olursa sistem çakılmayacak.

## Other

- [ ] Update Wiki.
- [ ] Update yuml.me
- [ ] Rake quality.