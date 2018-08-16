# Issue

Bu projenin tüm geliştirme süreçleri Github Issues ile yönetilmektedir. Issue bir sorun/hata bildirimi olabileceği gibi, bir özellik önerisi, değişiklik talebi de olabilir. Issue listesi kişisel/kurumsal bir to-do list değildir. Issue'lar oluşturulurken bir takım kurallara uyulmalıdır.

Sağlayacağınız katkıyla alakalı olarak bir iş kaydı açarak:

- Konunun proje ekibinin gündemine girmesini,
- Konu üzerinde önce tartışılmasını ve önerilerin alınmasını,
- Konunun öncelik durumunun tartışmaya açılmasını,
- Konuyla ilgili çalışan/çalışmayı düşünen diğer gönüllüleri bilgilendirmeyi,

sağlamış olacaksınız.

Açtığınız iş kaydı üzerinde karara bağlanan iş, size atandıktan sonra ilgili geliştirmeye yapmaya başlayabilirsiniz. Pull request açmadan önce iş kaydı açarak:

- PR'e review yapanları bu PR'in ne iş yaptığı ve buna neden gerek olduğu,
- PR'in kabul edilmesi durumunda CHANGELOG'a ne yazılacağını ve sürüm notlarında nelerden bahsedileceği

konusuda önceden bildirmiş olursunuz.

Sağlamayı düşündüğünüz katkı proje ekibinin gündeminde bulunmayabilir. Sizin için çok önemli görünen bir konu, proje ekibinin öncelikleri arasında yer almayabilir. Sizin çözüm getirdiğinize inandığınız bir konu, gelecekte başka bir yöntemle çözülmek üzere bekletiliyor olabilir, bir başka geliştirici zaten bu konu üstünde çalışıyor olabilir. Tüm bu durumların önüne geçmek için öncelikle issue açmanız gerekmektedir.

## Issue Başlığı
----------------

- İş kaydının başlığı emir kipinde yazılmış bir **sorun veya öneri** cümlesi olmalıdır. Örneğin:

```
YANLIŞ: Katkı sağlama rehberi hazırla
DOĞRU: Katkı sağlama rehberi eksik
DOĞRU: Katkı sağlama rehberi hazırlanmalı
```

Hatalı örnekte başlık sorun/öneri cümlesi içermiyor.

```
YANLIŞ: Dokku ve ruby
DOĞRU: Dokku'da yanlış ruby versiyonu kuruluyor
```

Hatalı örnekte sorun açıklanmıyor, başlık okuyana herhangi bir şey ifade etmiyor.

```
YANLIŞ: Ders: Ders ekleme sırasında okutulma türünün seçilmesini sağla
DOĞRU: Ders ekleme sırasında dersin okutulma türü seçilebilmeli
```

Hatalı örnekte `prefix` yoluyla kategorizasyona gidilmiş. Eğer bir seri halinde iş kayıtları mevcutsa bunlar bir `milestone` altında gruplanmalı. Ayrıca _seçilmesini sağla_ kelimeleri bir probleme/öneriye işaret etmiyor. _seçilebilmeli_ kelimesi şuan bu özelliğin mevcut olmadığına işaret etmekte. Hatalı örneğin başlığı bir PR için uygun, issue için değil.

```
YANLIŞ: Ülke, şehir ve ilçe seçimlerinde dynamic select'e ihtiyaç var
DOĞRU: Ülke, şehir ve ilçe seçimleri kullanışsız
```

Hatalı örnekte issue içerisinde konuşulması ve detaylandırılması gereken `dynamic_select` başlıkta verilmiş. Ülke, şehir ve ilçe seçimlerinin kullanışsız olması bir problem, bunun detayları ve olası çözümleri issue içerisinde konuşulmalı.

- İş kaydı bir to-do list değildir

```
YANLIŞ: DutyValidator ve EmployeeValidator'ü iyileştir
DOĞRU: DutyValidator ve EmployeeValidator'ü hatalı çalışıyor
DOĞRU: DutyValidator ve EmployeeValidator'de eksik validasyonlar var
```

Hatalı örneğin başlığı bir PR için uygun, issue için uygun değil.

- İş kaydının yalnızca ilk harfi büyük harf olmalı

```
YANLIŞ: KATKI SAĞLAMA REHBERİ HAZIRLA
YANLIŞ: katkı sağlama rehberi hazırla
DOĞRU: Katkı sağlama rehberi hazırla
```

İstisna olarak farklı stide yazılması gereken model isimleri (UserDuty), kısaltmalar (YÖK, MEB vb.) hala büyük harfle yazılmalıdır.

## Issue Gövdesi
----------------

Proje `.github` dizininde bulunan issue template'lerinden biri seçilerek iş kayıtları girilmelidir. Çok istisnai bir durum olmadıkça template'ler olmadan iş kaydı girilmemelidir.