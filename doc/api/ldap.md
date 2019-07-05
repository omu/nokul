---
author(s):
  - Recai Oktaş (@roktas)
---

LDAP
====

Kimlik Bilgisi Kategorileri
---------------------------

Kimlik bilgileri üç ana kategoride sunulmuştur: olmazsa olmaz nitelikte "Temel bilgiler", fihrist ve yetkilendirme
uygulamalarında gerekli "Standart bilgiler", özel uygulamalarda gerekebilecek "Ek bilgiler".  Bilgilerin "Gizlilik",
"Bütünlük" ve "Erişilebilirlik" nitelikleri farklılık gösterebilir.  Bu nitelikler aşağıda özetlenmiştir.

- Gizlilik:

  + Yok: Herhangi bir güvenlik kısıtlaması yok
  + Düşük: Bilgiye başka kaynaklardan da kolaylıkla erişilebiliyor
  + Orta: Kişisel bir bilgi
  + Yüksek: Bilgiye erişim için özel kurallar uygulanmalı

- Bütünlük:

  + Düşük: Bilginin güncelliği garanti edilemiyor
  + Orta: Bilgi güncel olmalı
  + Yüksek: Bilgi çok güncel; en fazla 24 saatlik gecikmeyle

- Erişilebilirlik:

  + Düşük: Bilginin erişilebilirliği garanti edilmiyor
  + Orta: Bilgi genel olarak erişilebilir durumda
  + Yüksek: Bilginin erişilebilirliği garanti ediliyor

### Temel Bilgiler

| Bilgi                              | Gizlilik   | Bütünlük   | Erişilebilirlik  |
|:-----------------------------------|------------|------------|------------------|
| `cn`                               | Düşük      | Orta       | Orta             |
| `displayName`                      | Düşük      | Orta       | Orta             |
| `eduPersonAffiliation`             | Düşük      | Orta       | Orta             |
| `eduPersonPrincipalName`           | Orta       | Yüksek     | Yüksek           |
| `eduPersonScopedAffiliation`       | Düşük      | Orta       | Orta             |
| `givenName`                        | Düşük      | Orta       | Orta             |
| `schacHomeOrganization`            | Düşük      | Orta       | Orta             |
| `sn`                               | Düşük      | Yüksek     | Yüksek           |
| `uid`                              | Düşük      | Yüksek     | Yüksek           |
| `userPassword`                     | Yüksek     | Yüksek     | Yüksek           |

### Standart Bilgiler

| Bilgi                              | Gizlilik   | Bütünlük   | Erişilebilirlik  |
|:-----------------------------------|------------|------------|------------------|
| `eduPersonPrimaryAffiliation`      | Düşük      | Orta       | Orta             |
| `jpegPhoto`                        | Yüksek     | Düşük      | Orta             |
| `mail`                             | Orta       | Yüksek     | Orta             |
| `mobile`                           | Yüksek     | Orta       | Orta             |
| `preferredLanguage`                | Düşük      | Orta       | Orta             |
| `schacPersonalUniqueCode`          | Orta       | Yüksek     | Orta             |
| `schacPersonalUniqueID`            | Orta       | Yüksek     | Yüksek           |
| `schacDateOfBirth`                 | Düşük      | Orta       | Orta             |
| `schacGender`                      | Orta       | Yüksek     | Yüksek           |
| `schacYearOfBirth`                 | Düşük      | Orta       | Orta             |

### Ek Bilgiler

| Bilgi                              | Gizlilik   | Bütünlük   | Erişilebilirlik  |
|:-----------------------------------|------------|------------|------------------|
| `eduPersonPrincipalNamePrior`      | Düşük      | Orta       | Düşük            |
| `schacCountryOfCitizenship`        | Düşük      | Orta       | Orta             |
| `schacExpiryDate`                  | Düşük      | Orta       | Orta             |
| `schacPlaceOfBirth`                | Düşük      | Orta       | Orta             |
| `schacUserStatus`                  | Düşük      | Orta       | Orta             |

Kimlik Bilgileri
----------------

### `cn`

| | |
|-|-|
| **İsim**    | `cn`                                                            |
| **Tanım**   | Tam isim                                                        |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok (tek önerilir)                                              |
| **OID**     | 2.5.4.3                                                         |
| **Kaynak**  | RFC 4519                                                        |
| **Örnek**   | `Mustafa Kemal Atatürk`                                         |

### `displayName`

| | |
|-|-|
| **İsim**    | `displayName`                                                   |
| **Tanım**   | Görüntülenen tam isim                                           |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Tek                                                             |
| **OID**     | 2.16.840.1.113730.3.1.241                                       |
| **Kaynak**  | RFC 2798                                                        |
| **Örnek**   | `Mustafa Kemal Atatürk`                                         |

Kişinin tam adı (bir web sayfası veya dokümanda) görüntülenirken bu bilgi kullanılmalıdır (`cn` ile aynı içeriğe sahip
olsa bile).

### `eduPersonAffiliation`

| | |
|-|-|
| **İsim**    | `eduPersonAffiliation`                                          |
| **Tanım**   | Kişinin kurumla ilişkisi                                        |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 1.3.6.1.4.1.5923.1.1.1.1                                        |
| **Şema**    | eduPerson                                                       |
| **Örnek**   | `faculty, employee, member` (örneğin bir profesör)              |

Geçerli değerler: `faculty`, `student`, `staff`, `alum`, `member`, `affiliate`, `employee`, `library-walk-in`

Çoklu değer alan bu bilgide değerlendirme yapılırken aşağıdaki ilişki ağacı dikkate alınmalıdır.

        eduPersonAffiliation
        |
        |
        +----+ alum
        |
        |
        +----+ affiliate
        |
        |
        +----+ library-walk-in
        |
        |
        +----+ member
                    +
                    |
                    |
                    +----+ student
                    |
                    |
                    +----+ employee
                                  +
                                  |
                                  |
                                  +----+ faculty
                                  |
                                  |
                                  +----+ staff

Bu ilişki ağacına göre aşağıdaki tanımlar göz önünde tutulmalıdır.

- `member`: Kişinin kurumla resmi ve canlı bir ilişkisi olduğunu belirtir.  `student`, `faculty`, `staff` ve `employee`
  değerlerinden herhangi birisi girildiğinde bu değer de girilmelidir.

  + student: Aktif öğrenci

  + employee: Kurum personeli.  `faculty` ve `staff` değerlerinden herhangi birisi girildiğinde bu değer de
    girilmelidir.

    * faculty: Akademik personel

    * staff: Akademik olmayan personel

- `member` olmayan bir kişi 3 durumdan birinde (veya özel senaryolarda bir kaçında) olabilir.

  + `alum`: Mezun

  + `affiliate`: `member` olmayan fakat kurumun sunduğu belirli hizmetlerden yararlanabilmek için bir şekilde kayıtlı
    olması gereken misafir, gönüllü, denetleyici gibi kişiler

  + `library-walk-in`: Kütüphane veya kamuya açık bilgisayar salonu gibi bazı kamusal hizmetlerden yararlanabilmek için
    oluşturulan kişi kaydı

### `eduPersonPrimaryAffiliation`

| | |
|-|-|
| **İsim**    | `eduPersonPrimaryAffiliation`                                   |
| **Tanım**   | Kişinin kurumla birinci derece ilişkisi                         |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Tek                                                             |
| **OID**     | 1.3.6.1.4.1.5923.1.1.1.5                                        |
| **Şema**    | eduPerson                                                       |
| **Örnek**   | `faculty`                                                       |

Geçerli değer için `eduPersonAffiliation` bilgisine bakınız.

### `eduPersonPrincipalName`

| | |
|-|-|
| **İsim**    | `eduPersonPrincipalName`                                        |
| **Tanım**   | Kişinin ilgili alandaki ana ismi                                |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Tek                                                             |
| **OID**     | 1.3.6.1.4.1.5923.1.1.1.6                                        |
| **Şema**    | eduPerson                                                       |
| **Örnek**   | `ataturk@omu.edu.tr`                                            |

Bu bilgi `uid` bilgisinin `schacHomeOrganization` bilgisiyle (`@` ile ayırarak) birleştirilmesiyle oluşturulur.

`eduPersonPrincipalName` bilgisi ilgili kişi kurumdan ayrılsa bile tercihen yeniden kullanılmamalıdır.  Yeniden
kullanılacaksa bu tutarlı bir politikaya uygun şekilde (ör. en az 24 ay aralıklarla) gerçekleştirilmelidir.

### `eduPersonPrincipalNamePrior`

| | |
|-|-|
| **İsim**    | `eduPersonPrincipalNamePrior`                                   |
| **Tanım**   | Kişinin ilgili alandaki önceki ana isimleri                     |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 1.3.6.1.4.1.5923.1.1.1.12                                       |
| **Şema**    | eduPerson                                                       |
| **Örnek**   | `mkemal@omu.edu.tr`                                             |

### `eduPersonScopedAffiliation`

| | |
|-|-|
| **İsim**    | `eduPersonScopedAffiliation`                                    |
| **Tanım**   | Kişinin kurumla kapsamlandırılmış ilişkisi                      |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 1.3.6.1.4.1.1466.115.121.1.15                                   |
| **Şema**    | eduPerson                                                       |
| **Örnek**   | `student@_.bilgisayar-pr.bilgisayar.muhendislik.omu.edu.tr`     |

Geçerli değer için _ilişki_`@`_birim tanımlayıcı_`.`_alan adı_ biçimindedir.

- _ilişki_: `eduPersonAffiliation` bilgisinde kullanılan geçerli değerlerden biri olmalı: `faculty`, `student`, `staff`,
  `alum`, `member`, `affiliate`, `employee`, `library-walk-in`

- _birim tanımlayıcı_: Kişinin ilişkisinin hangi birimde olduğunu belirten ve _iNSS_ biçimde yazılan tanımlayıcı.  Bu
  değer tipik olarak üniversite birim ağacı içinde birimin yerini tarif eden `.` ile ayrılmış birim kısaltmalarından
  türetilmiş tanımlayıcılardan oluşur.  Birim kısaltmaları tanımlayıcıya dönüştürülürken küçük harf kullanılır ve Türkçe
  karakter ASCII eşdeğerleriyle değiştirilir.  Tanımlayıcılar en alt (yaprak) birimden üst birimlere doğru dizilmelidir.
  En tepedeki kök birim (ör. üniversite) girilmeyebilir.  Dizginin başlangıcında isteğe bağlı olarak bir önek bileşeni
  kullanılabilir.

  Örnek: Ondokuz Mayıs Üniversitesi Mühendislik Fakültesi (`MÜHENDİSLİK` → `muhendislik`), Bilgisayar Mühendisliği
  bölümü (`BİLGİSAYAR` → `bilgisayar`) Bilgisayar Mühendisliği önlisans/lisans programı (`BİLGİSAYAR-PR` →
  `bilgisayar-pr`) birimi.

        _.bilgisayar-pr.bilgisayar.muhendislik.omu.edu.tr

  Örnek: Ondokuz Mayıs Üniversitesi Mühendislik Fakültesi (`MÜHENDİSLİK` → `muhendislik`) Mühendislik Fakültesi
  Dekanlığına (`MÜHENDİSLİK-DEK` → `muhendislik-dek`) bağlı Fakülte yönetim kurulu (`MÜHENDİSLİK-KUR` →
  `muhendislik-kur`) idari birimi.

        _.muhendislik-kur.muhendislik-dek.muhendislik.omu.edu.tr

- _alan adı_: Organizasyona ilişkin "RFC 1035"e uyumlu alan adı

### `givenName`

| | |
|-|-|
| **İsim**    | `givenName`                                                     |
| **Tanım**   | İsim                                                            |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 2.5.4.42                                                        |
| **Kaynak**  | RFC 4519                                                        |
| **Örnek**   | `Mustafa`                                                       |

### `jpegPhoto`

| | |
|-|-|
| **İsim**    | `jpegPhoto`                                                     |
| **Tanım**   | Profil resmi                                                    |
| **Biçim**   | JPEG                                                            |
| **Değer**   | Çok                                                             |
| **OID**     | 0.9.2342.19200300.100.1.60                                      |
| **Kaynak**  | RFC 2798                                                        |
| **Örnek**   | -                                                               |

### `mail`

| | |
|-|-|
| **İsim**    | `mail`                                                          |
| **Tanım**   | E-posta                                                         |
| **Biçim**   | IA5String                                                       |
| **Değer**   | Çok                                                             |
| **OID**     | 0.9.2342.19200300.100.1.3                                       |
| **Kaynak**  | RFC 4524                                                        |
| **Örnek**   | `ataturk@omu.edu.tr`                                            |

### `mobile`

| | |
|-|-|
| **İsim**    | `mobile`                                                        |
| **Tanım**   | Cep telefonu numarası                                           |
| **Biçim**   | TelephoneNumber                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 0.9.2342.19200300.100.1.41                                      |
| **Kaynak**  | RFC 4524                                                        |
| **Örnek**   | `+90 362 312 1919`                                              |

Geçerli değerler "ITU Recommendation E.123" biçimindedir.

### `preferredLanguage`

| | |
|-|-|
| **İsim**    | `preferredLanguage`                                             |
| **Tanım**   | Tercih edilen iletişim dili                                     |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 2.16.840.1.113730.3.1.39                                        |
| **Kaynak**  | RFC 2798                                                        |
| **Örnek**   | `tr`                                                            |

Geçerli değerler "ISO 639" ülke/dil kodudur.

### `schacCountryOfCitizenship`

| | |
|-|-|
| **İsim**    | `schacCountryOfCitizenship`                                     |
| **Tanım**   | Kişinin vatandaşı olduğu ülke                                   |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.11                                        |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `tr`                                                            |

Geçerli değerler "ISO 3166" ülke kodlarıdır.

### `schacExpiryDate`

| | |
|-|-|
| **İsim**    | `schacExpiryDate`                                               |
| **Tanım**   | İlgili kaydın son geçerlilik tarihi                             |
| **Biçim**   | Time                                                            |
| **Değer**   | Tek                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.17                                        |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `20051231125959Z`                                               |

Geçerli değer `YYYYMMDDhhmmssZ` biçiminde UTC zaman değeridir (saniyeler de dahil edilmeli).

### `schacPersonalUniqueCode`

| | |
|-|-|
| **İsim**    | `schacPersonalUniqueCode`                                       |
| **Tanım**   | Kişiye özgü tekil kodlar                                        |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.14                                        |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `urn:schac:personalUniqueCode:tr:studentID:omu.edu.tr:20319073` |
|             | `urn:schac:personalUniqueCode:tr:employeeID:omu.edu.tr:12345`   |

Geçerli değerler "`urn:schac:personalUniqueCode:`_ülke kodu_`:`_iNSS_" biçimindedir.

- _ülke kodu_: "ISO 3166" ülke kodu veya ilgili kod uluslar arası sınırlarda geçerli olacaksa `int`

- _iNSS_: "RFC 2141"de belirtilen küçük/büyük harf duyarsız "Namespace Spesific String"

URN kayıtları [Terena](http://www.terena.org/registry/terena.org/schac/personalUniqueCode/) üzerinde yapılmaktadır.

### `schacPersonalUniqueID`

| | |
|-|-|
| **İsim**    | `schacPersonalUniqueID`                                         |
| **Tanım**   | Kişiye özgü tekil kimlik numaraları                             |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.15                                        |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `urn:schac:personalUniqueID:tr:NIN:10570898198`                 |

Geçerli değerler "`urn:schac:personalUniqueID:`_ülke kodu_`:`_ID tipi_`:`_ID_" biçimindedir.

- _ülke kodu_: "ISO 3166" ülke kodu veya ilgili kod uluslar arası sınırlarda geçerli olacaksa `int`

- _ID tipi_: "Terena URN Registery"de kayıtlı ID tipi

URN kayıtları [Terena](http://www.terena.org/registry/terena.org/schac/personalUniqueID/) üzerinde yapılmaktadır.

### `schacUserStatus`

| | |
|-|-|
| **İsim**    | `schacUserStatus`                                               |
| **Tanım**   | Kullanılan servislerdeki hesap durumları                        |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.19                                        |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `urn:schac:userStatus:tr:omu.edu.tr:affiliation:expired`        |

Geçerli değerler "`urn:schac:userStatus:`_ülke kodu_`:`_alan adı_`:`_iNSS_" biçimindedir.

- _ülke kodu_: "ISO 3166" ülke kodu veya ilgili kod uluslar arası sınırlarda geçerli olacaksa `int`

- _alan adı_: Organizasyona ilişkin "RFC 1035"e uyumlu alan adı

- _iNSS_: "RFC 2141"de belirtilen küçük/büyük harf duyarsız "Namespace Spesific String"

### `schacDateOfBirth`

| | |
|-|-|
| **İsim**    | `schacDateOfBirth`                                              |
| **Tanım**   | Doğum tarihi                                                    |
| **Biçim**   | Numeric String                                                  |
| **Değer**   | Tek                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.3                                         |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `19660412`                                                      |

Geçerli değer `YYYYMMDD` biçimindedir.

### `schacGender`

| | |
|-|-|
| **İsim**    | `schacGender`                                                   |
| **Tanım**   | Cinsiyet                                                        |
| **Biçim**   | Tamsayı                                                         |
| **Değer**   | Tek                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.2                                         |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `2`                                                             |

Geçerli değerler:

- `0`: bilinmiyor
- `1`: erkek
- `2`: kadın
- `9`: belirtilmemiş

### `schacHomeOrganization`

| | |
|-|-|
| **İsim**    | `schacHomeOrganization`                                         |
| **Tanım**   | Kişinin bağlı olduğu organizasyon                               |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Tek                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.9                                         |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `omu.edu.tr`                                                    |

Geçerli değer organizasyona ilişkin "RFC 1035"e uyumlu alan adıdır.

### `schacPlaceOfBirth`

| | |
|-|-|
| **İsim**    | `schacPlaceOfBirth`                                             |
| **Tanım**   | Doğum yeri                                                      |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Tek                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.2.4                                         |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `Samsun, Türkiye`                                               |

Doğum yeri tercihen il ve ülke olarak verilmelidir.

### `schacYearOfBirth`

| | |
|-|-|
| **İsim**    | `schacYearOfBirth`                                              |
| **Tanım**   | Doğum yılı                                                      |
| **Biçim**   | Numeric String                                                  |
| **Değer**   | Tek                                                             |
| **OID**     | 1.3.6.1.4.1.25178.1.0.2.3                                       |
| **Kaynak**  | SCHAC                                                           |
| **Örnek**   | `1966`                                                          |

Geçerli değer `YYYY` biçimindedir.

### `sn`

| | |
|-|-|
| **İsim**    | `sn`                                                            |
| **Tanım**   | Soyad                                                           |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok                                                             |
| **OID**     | 2.5.4.4                                                         |
| **Kaynak**  | RFC 4519                                                        |
| **Örnek**   | `Atatürk`                                                       |

### `uid`

| | |
|-|-|
| **İsim**    | `uid`                                                           |
| **Tanım**   | Tanımlayıcı                                                     |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok (tek önerilir)                                              |
| **OID**     | 0.9.2342.19200300.100.1.1                                       |
| **Kaynak**  | RFC 4519                                                        |
| **Örnek**   | `ataturk`                                                       |

Bu bilgi `eduPersonPrincipalName` bilgisinin `@` karakterinden önce gelen kullanıcı adı kısmıyla aynıdır.

### `userPassword`

| | |
|-|-|
| **İsim**    | `userPassword`                                                  |
| **Tanım**   | Parola                                                          |
| **Biçim**   | DirectoryString                                                 |
| **Değer**   | Çok (tek önerilir)                                              |
| **OID**     | 2.5.4.35                                                        |
| **Kaynak**  | RFC 4519                                                        |
| **Örnek**   | -                                                               |

Kaynaklar
---------

1. [UNINETT, Feide Technical Guide, Technical details for integrating a service into Feide](https://www.feide.no/sites/feide.no/files/documents/feide_technical_guide.pdf)
2. [UNINETT, norEdu Object Class Specification](https://www.feide.no/sites/feide.no/files/documents/norEdu_spec.pdf)
3. [UNINETT, Feide Integration Guide, Integrating a service provider with Feide](https://www.feide.no/sites/feide.no/files/documents/feide_integration_guide.pdf)
4. [GrNET, Authentication and Authorisation Infrastructure, Policy and Procedures](http://aai.grnet.gr/static/policy/policy-en.pdf)
5. [SWITCH, AAI - Authentication and Authorization Infrastructure, Attribute Specification](https://www.switch.ch/aai/docs/AAI_Attr_Specs.pdf)
6. [Interoperable SAML 2.0 Web Browser SSO Deployment Profile](http://saml2int.org/profile/current)
7. [SimpleSAMLphp](http://simplesamlphp.org/)
8. [SCHAC - SCHema for ACademia](https://wiki.refeds.org/display/STAN/SCHAC+Releases)
9. [inetOrgPerson - RFC2798](https://www.ietf.org/rfc/rfc2798.txt)
10. [eduPerson](http://software.internet2.edu/eduperson/internet2-mace-dir-eduperson-201602.html)
11. [funetEduPerson](https://wiki.eduuni.fi/display/CSCHAKA/funetEduPersonSchema2dot2)
12. [REFEDS, The Research and Education Federations Group](https://refeds.org/)
13. [eduGAIN](https://edugain.org/)
