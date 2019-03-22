---
author: Recai Oktaş
---

`Codification`
==============

`Codification` modülü entitelere kod ataması yapmakta kullanılan sınıflardan
oluşmaktadır.

Temelde bir [`Enumerator`](https://ruby-doc.org/core-2.6.2/Enumerator.html)
nesnesi olan `Code` verilen bir "kaynağı" bir `Enumerator"e çevirir ("convert")
ve her ardışımda bir String dizisi yayımlar ("emit").  Yayımlanan String dizisi
seçenek olarak verilen ön ek, son ek ve ara ekler dikkate alınarak nihai "kod"
olan String'e çevrilir.

Üretilen kodun tekilliğine ve uygunluğuna (ör. ofensif olup olmaması) `Coder`
nesnesi  karar verir.  Tekillik denetimi `Memory` nesnesi üzerinden, uygunluk
denetimi ve son işleme (ör. rastgele son ek ekle) `Processor` nesnesi üzerinden
gerçekleşir.

Tüm kodlama gerçeklemeleri `codes` dizini altında basit bir eklenti düzeninde
tutulur.  Bu düzen içinde her kodlama türü aslında `Code` ve/veya `Coder`
nesnelerini özelleştirilmesinden ibarettir.

TODO
