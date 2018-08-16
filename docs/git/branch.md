# Branch

## Branch Yapısı
----------------

- Projenin yayında bulunan sürümü `master` branch'inde bulunmaktadır.
- Projenin aktif geliştirme alan kararlı sürümü `develop` branch'inde bulunmaktadır.
- `develop` branch'i sürüm yöneticisi (release manager) tarafından uygun görülen zamanlarda `master`'a merge edilerek yayına alınır. Dolayısıyla `develop` branch'i her zaman `master`'dan daha güncel ve önde gitmektedir.
- Geliştiriciler sağlayacakları her türlü katkı için (ufak bir imla düzeltmesi dahil) kendi branch'lerini oluşturmalıdır.
-  `master` ve `develop` branch'leri protected branch'ler olup geliştiriciler bu branch'lere doğrudan commit push edemezler.
- Geliştiriciler kendi branch'lerini daima `develop`'tan oluşturmalıdırlar. `master` branch'i geriden geldiği için, yeni branch oluştururken kaynak olarak kullanılmamalıdır.
- Özetle bu proje `develop` -> `gelistici-branchi` -> `develop` -> `master` akışını izlemektedir.

## Branch İsimlendirme
----------------------

- Branch isimleri tümü küçük harf, Türkçe karakter içermeyen (branch ismi Türkçe olabilir) metinlerden oluşmalıdır.

```
YANLIŞ: Redesign-Login-Page
DOĞRU: redesign-login-page
```

- Sürüm numarasını ifade edebileceği için branch isimleri rakam ile başlamamalıdır.

```
YANLIŞ: 1-den-baslat
DOĞRU: birden-baslat
```

- Branch isimleri kısa, net ve anlaşılır olmalıdır.

```
YANLIŞ: fix-errors
DOĞRU: fix-auth-error-in-ldap
```

- Branch isimlerinde kelimeler `tire` ile ayrılmalıdır.

```
YANLIŞ: redesign_login_page
DOĞRU: redesign-login-page
```

## Branch'i Güncel Tutma
------------------------

Üzerinde geliştirme yaptığınız ve `develop`'tan oluşturduğunuz branch yine `develop`'a merge edileceği için - üzerinde çalıştığınız branch'i düzenli olarak `develop`'la güncelleyiniz. Aksi halde conflict oluşabilir. Aşağıda bu süreç basitçe gösterilmiştir:

```bash
git checkout kendi-branchiniz # kendi branch'inizde çalışırken
git add --all # commitlenmemiş değişiklik varsa
git commit -m 'Commit my changes' # önce commitleyin
git checkout develop # sonra develop'a geçerek
git pull origin develop # develop'un en güncel halini çekin
git checkout kendi-branchiniz # kendi branch'inize dönün
git merge develop # develop'un güncel halini branch'inize merge edin
git commit -m 'Fix conflicts' # (varsa) conflict'leri düzeltin
```

> `develop` ile güncel tutulmamış hiç bir branch conflict oluşturmasa dahi, branch'inizi güncellemediğiniz sürece merge edilmeyecektir.

## Acil Seviyeli Branch
-----------------------

Bir branch'in önce `develop`'a merge edilmesi, daha sonra `develop`'un ise `master`'a merge edilmesi ve `deploy` işleminin (ortalama ~15 dakika) gerçekleşmesi CI entegrasyonlarının hızına bağlı olarak yaklaşık 30 dakika sürmektedir.

Bir güvenlik açığının düzeltilmesi gibi acilen yayına alınması gereken bir değişiklik için doğrudan `master`'a PR açabilirsiniz. Ancak hiç bir sebeple, **asla** doğrudan `master`'a push yapmayınız.

## Branch'lerin Silinmesi

Tüm geliştirici branch'leri `develop`'a merge edildikten sonra anında silinmektedir. Henüz hakkında PR açılmamış ve WIP durumundaki branch'ler uzun süre (~ 3 ay) aktiflik göstermediği taktirde silinebilir.
