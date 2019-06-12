Katkı sunma rehberi
===================

Bu rehber bu projeye (bundan sonra [Proje](../) olarak anılacaktır) gönüllü katkı sunmak isteyenlere ve projede görevli
olarak çalışanlara yönelik olarak hazırlanmıştır.

Beyanat
-------

Projeye katkı yaparak Ondokuz Mayıs Üniversitesi [bilişim
politikalarını](https://github.com/omu/resmi/tree/master/bilgi-g%C3%BCvenli%C4%9Fi-politikas%C4%B1) ve gelecekte
eklenmesi muhtemel yeni politikaları peşinen kabul ettiğinizi beyan etmiş sayılırsınız.

Proje ve projede ortaya çıkan ürünlerin tüm hakları Ondokuz Mayıs Üniversitesine aittir. Uygulamaya yapacağınız
katkıların hakları da Ondokuz Mayıs Üniversitesine ait olacaktır. Projede çalışma sorumluluğu bulunmayan kişilerin
yaptıkları katkılar tamamen gönüllü katkı olarak değerlendirilecek olup, bu kişilerin yaptıkları katkılar için telif
hakkı, ücret, projenin herhangi bir yerinde isminin anılması (mention) gibi herhangi bir istekte bulunma hakları
bulunmamaktadır. `Katkı sağlayan` olarak kullanıcı adınız, isminiz, sağladığınız katkı ve katkı sağladığınız tarih gibi
bilgiler bu projede herkese açık bir biçimde görüntülenebilir. Projeye yapacağınız katkılar Ondokuz Mayıs Üniversitesine
ait olacağı için gelecekte yaptığınız katkıların projeden kaldırılmasını talep etme hakkınız bulunmamaktadır.

Proje gelecekte herkese açık (public) bir proje olmayı garanti etmemektedir.  Projenin görünürlüğü Ondokuz Mayıs
Üniversitesi tarafından gerekli görüldüğü takdirde gizli (private) duruma çekilebilir. Bu durumda sağladığınız katkının
kullanılmaya devam edeceğini peşinen kabul etmiş sayılırsınız. Projenin güncel lisansı
[LICENSE.md](/LICENSE.md) dosyasında açıkça sunulmuştur.

Güvenlik açığı bildirimi
------------------------

Projede herhangi bir güvenlik açığı tespit ederseniz lütfen `security@baum.omu.edu.tr` adresinden bildirim yapınız.
Güvenlik açığı bildirimleri için herkese açık olan `issues` sayfasını kullanmayınız.

Neye katkı yapabilirim
-----------------------

İsteyen herkes, Projede görebildiği her şeye katkı yapabilir. Projenin kaynak koduna, tasarımına, dokümanlarına, açık iş
kayıtlarına, açık katkı taleplerine (pull request) ve diğer kısımlarına katkı yapabilirsiniz.

------------------------------------

Katkı sağlama iş akışı
----------------------

### İş kayıtları (Issue)

- Projeye katkı sağlamadan önce, katkı sağlamak istediğiniz konuyla ilişkili bir iş kaydı açın. İş kaydı bulunmayan ve
  bir iş kaydına atıfta bulunmayan pull request'ler değerlendirmeye alınmayabilir veya geç değerlendirmeye alınabilir.

- [Issue](/doc/workflow/issue.md) kurallarını dikkatlice gözden geçirin.

### Geliştirme öncesi

Bu projenin bazı kısımları gönüllülerden gelecek katkılara açık olmakla birlikte, projenin bazı kısımları birtakım
kısıtlı servisler ile haberleşmekte ve çeşitli erişim bilgilerine ihtiyaç duymaktadır.

- Sırlar

  Organizasyon sırları kurumsal bir sır deposunda tutulmaktadır. Bu sırlara erişim için [sistem
  grubu](https://github.com/orgs/omu/teams/ops) ile iletişime geçebilirsiniz.

- Master.key ve API Anahtarları

  Proje sırları `credentials.yml.enc` dosyasında tutulmaktadır. Bu dosyaya erişim bilgilerini [sistem
  grubu](https://github.com/orgs/omu/teams/ops)'ndan edindikten sonra `RAILS_MASTER_KEY` ve `TENANT_MASTER_KEY` ortam
  değişkenlerini sisteminize tanımlayın.

- VPN

  Harici servisler yalnızca [BAUM-VPN](https://doc.omu.sh/services/vpn.md#baum-vpn)'e açıktır. Geliştirme yaparken
  ihtiyaç duyacağınız bu servisleri kullanmak için BAUM-VPN'e bağlı olmalısınız. VPN erişimi için [sistem
  grubu](https://github.com/orgs/omu/teams/ops) ile iletişime geçin. Tüm geliştirme süreciniz boyunca ve testleri
  çalıştırırken mutlaka BAUM-VPN'e bağlı olun.

### Geliştirme süreci

- Projeye yazma yetkiniz varsa projeyi klonlayın, yazma yetkiniz yoksa projeyi `fork` edin.

- [Branch](https://doc.omu.sh/workflow/branch.md) kurallarını dikkatlice gözden geçirin.

- Proje klonunda veya kendi "fork" kopyanızda, branch kurallarını dikkate alan bir branch oluşturun: `git checkout -b
  my-awesome-feature`

- [Kurulum dokümanını](/doc/development/installation.md) takip ederek Projenin kurulumunu yapın.

- [Stil](https://doc.omu.sh/policy/) kurallarını dikkatlice gözden geçirin.

- Kod üzerinde değişiklikleri yapın.

- [Commit](https://doc.omu.sh/workflow/commit.md) kurallarını dikkatlice gözden geçirin.

- Değişiklerinizi commit'leyin.

- [Test Coverage](/doc/development/test-coverage.md) kurallarını dikkatlice gözden geçirin.

- Yaptığınız değişikliğin test coverage oranını düşürmediğinden emin olun.

- Değişikliklerinizi push etmeden önce çeşitli kontrolleri gerçekleştiren `pull_request` rake task'ini çalıştırın (`rake
  pull_request`)

- `pull_request` task'inden hata aldıysanız öncelikle bunları çözün ve commit'leyin.

- `pull_request` task'i başarıyla çalışıyorsa commit'lerinizi kendi branch'inize push edin.

### Geliştirme sonrası

- [Pull Request](https://doc.omu.sh/workflow/pr) kurallarını dikkatlice gözden geçirin.

- Geliştirmenizi tamamladıktan sonra kendi branch'inizden `develop`'a doğru bir `pull request` (diğer adıyla `merge
  request`) açın.

- [Review](https://doc.omu.sh/workflow/review) kurallarını dikkatlice gözden geçirin.

- Pull request'inizin review sürecinin tamamlanmasını bekleyin.

### Dokümantasyon

Tüm dokümanlar [doc](doc) dizini altında [dokümantasyon kurallarına](https://doc.omu.sh/policy/documentation) uygun
şekilde tutulmaktadır.  Dokümanlar CI'da [Markdownlint](https://github.com/DavidAnson/markdownlint) denetiminden
geçirilmektedir.  Denetimde kullanılan özel kurallar için [.markdownlintrc](/.markdownlintrc) yapılandırmasına
bakabilirsiniz.

Dokümanları hatasız düzenlemek için:

- Markdownlint aracını kurun

  ```sh
  npm install -g markdownlint-cli
  ```

- Editörünüze Markdownlint desteği ekleyin

  + VIM için [ALE](https://github.com/w0rp/ale) eklentisini kurun

  + VSCode için ilgili [yapılandırmayı](https://doc.omu.sh/etc/vscode.md) uygulayın

  + Sublime için [Sublime Text
    Markdownlint](https://github.com/jonlabelle/SublimeLinter-contrib-markdownlint)
    eklentisini kurun
