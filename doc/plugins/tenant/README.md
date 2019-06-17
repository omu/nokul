---
author(s):
  - Recai Oktaş (@roktas)
---

Kiracılar
=========

Nokul uygulamasının müşterilerine, örneğin "Ondokuz Mayıs Üniversitesi", "kiracı" ("tenant") diyoruz.  Her kiracı
(Türkçe karakter ve boşluk içermeyen) kısa bir tanımlayıcıyla temsil ediliyor, ör. Ondokuz Mayıs Üniversitesi için
`omu`.

Uygulamayı belirli bir kiracıya özgü kılmamak için uygulama kökünde `tenant` adında bir dizin ayrılmıştır.  "Kiracı
özgünlüklerini" bu kök dizin altındaki "kiracı dizinleri"nde yönetiyoruz.  Örneğin `omu` kiracısına ait tüm özgünlükler
`/tenant/omu` dizininde barınıyor.  Özel olarak tüm kiracılar için ortak olan (ve bu yönüyle özgün olmayan), ama yine de
uygulamanın içinde "hard coded" olarak tutulması uygun görülmeyen kiracı bilgilerini de `/tenant/common` dizininde
tutuyoruz.

Kiracı dizinlerini Rails uygulama kökünü izleyen biçimde alt dizinler halinde düzenlemeyi tercih ediyoruz.   Örneğin
`omu` kiracısına ait yapılandırma bilgileri `/tenant/omu/config` dizininde.

Uygulama hangi kiracı için konuşlandırılmışsa o kiracıya "etkin kiracı" (`Tenant.active`) diyoruz.  Etkin kiracı
tanımlayıcısı uygulama konuşlandırılırken `RAILS_TENANT` ortam değişkeniyle uygulamaya iletiliyor.

Kiracı özgünlükleri
-------------------

Kiracıya özgü "şeyler" genel olarak YAML gibi bir veri biçimiyle deklaratif halde temsil edilen pasif bilgiler oluyor,
ör. kiracı yapılandırmaları.  Fakat kiracı özgünlüklerini bununla sınırlayamıyoruz.  Özgünlükleri kabaca aşağıdaki gibi
kategorize edebiliriz:

- `config`: Uygulamanın sunduğu bir "servis"in çalışma biçimini kiracıya özgü kılan deklaratif yapılandırmalar.  YAML
  biçiminde temsil edilen bu bilgiler genel olarak etkin kiracıya ait `config` dizininde kayıtlı olan bir dizi
  yapılandırma dosyasından oluşuyor.

  Bu yapılandırmaların sadece tipik Rails yapılandırmaları ile sınırlı olmadığını unutmayalım.  Örneğin geliştirilen
  genel bir modül ile kiracıya özgü bir numaralandırma (ör. birim numaralandırması) yapılacaksa, numaralandırma lojiği
  yine `config` dizinindeki dosyalarla şekillendiriliyor.

  Önerilen alt dizin `config`.

- `db`: Uygulamanın kiracı modellerinin kiracıya özgü şekilde kurulması sürecinde kullanılan ilk veriler.  Örneğin
  kiracının YÖKSİS ve DETSİS üzerinden çekilen organizasyon ağacı (birimler) bilgilerinin "kanonik formda" temsili.

  Önerilen alt dizin `db`.

- `assets`: Uygulamanın müşteri markalandırmasında kullanılan kiracıya özgü tüm dijital varlıklar, ör. görseller, CSS ve
  Javascript dosyaları.

  Önerilen alt dizin `app/assets`.

- `test`: Kiracı özgünlüklerinin doğru yönetilip yönetilmediğini sınayan test kodları.

  Önerilen alt dizin `test`.

- `app`: Kiracıya özgü lojik farklılıklarını gerçekleyen ve daima uygulama tarafından sunulan bir API'yi tüketen Ruby
  kodları.

  Kiracı özgünlükleri anlamında belki de temsil edilmesi en zor bilgi türü bu oluyor.  Genel olarak bunu yapmaktan yani
  kiracı dizinlerinde aktif kod barındırmaktan kaçınıyoruz.  Ama bu kaçınılmaz ise ucu açık kodlar yerine tercihen
  `/lib/support` veya `/app/services` altındaki modüllerde gerçeklenen API'leri tüketen kodlar yazarak kiracı dizinine
  koyuyoruz.

  Önerilen alt dizin: `app`.

Kiracı ilk konuşlandırma prosedürü
----------------------------------

Yeni bir kiracı geldiğinde sırayla aşağıdaki prosedürü uyguluyoruz.

1. Kiracı için bir tanımlayıcı oluştur ve bu tanımlayıcıyla yeni bir kiracı dizini ekle.

2. Kiracı yapılandırmasını `config/config.yml` dosyasında ilkle.

3. Kiracının YÖKSİS ve DETSİS ağaçlarını Xokul ile çekerek kanonik formda sırasıyla `db/src/yok.yml` ve `db/src/det.yml`
   dosyalarında kayıtla.

4. Her iki kaynak dosyada birim kısaltmalarını ("abbreviations") elle oluştur.

5. DETSİS kaynağında (`db/src/det.yml`) ilgili birimleri YÖKSİS ağacındaki üst birimle elle ilişkilendir.

   Ör. Bir idari birim olarak "Mühendislik Fakültesi Dekanlığı"nı YÖKSİS'teki "Mühendislik Fakültesi" akademik birimini
   üst birim kabul edecek şekilde ilişkilendir.  Bu işlemin tüm idari birimler için yapılmadığını not edelim. Ör. üst
   birimi de bir idari birim olan bir birimi bir YÖKSİS birimiyle ilişkilendirmek gerekmiyor.

6. Tüm kaynak dosyalardan `db/units.yml` dosyasını üret.
