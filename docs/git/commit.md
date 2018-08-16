# Commit

- Projeyi `bundle` ettikten sonra `fit-commit` git hook'larını kurun: `fit-commit install`

- Her bir commit'in kendi içerisinde anlamsal bir bütünlüğe sahip olması için özen gösterin. Yaptığınız tüm değişiklikleri tek bir commit mesajı ile commitlemeyin.

- Her bir commit yalnızca tek anlamsal değişikliği ifade etmeli. Örneğin hem bir bug'ı düzelttiniz, hem de renki hatalı olan bir butonun rengini düzelttiyseniz bunları ayrı ayrı commitleyin.

- Erken ve sık aralıklarla commit edin. Küçük ve bağımsız commitlerin anlaşılması ve eski haline döndürülmesi bir şeylerin yanlış gitmesi durumunda daha kolaydır.

- Commit mesajı yazarken terminal değil editör kullanın:

```
YANLIŞ: git commit -m 'Foo bar lorem ipsum'
DOĞRU: git commit
```

Güzel bir commit mesajının 7 altın kuralını takip edin:

1. Commit başlığı ve gözdesini boş bir satırla ayırın
1. Commit başlığını 72 karakterle sınırlayın
1. Başlığın ilk harfini büyük harf yapın
1. Başlık cümlesini nokta işareti ile bitirmeyin
1. Başlıkta emir kipi kullanın
1. Commit gövdesini 72 karakterle sınırlayın
1. Commit gövdesinde ne, neden ve nasıl sorularını yanıtlayacak şekilde commit'in yaptığı işi açıklayın.


## Commit Başlığı
-----------------

- Commit başlığını daima büyük harfle başlatıp küçük harflerle devam ettirin.

```
YANLIŞ: ADD AUTHORIZATION ROLES AS ADMIN AND USER
YANLIŞ: add authorization roles as admin and user
DOĞRU: Add authorization roles as admin and user
```

- Commit başlığını en fazla 72 karakterden, tercihen ise 50 karakterden oluşacak şekilde düzenleyin.

```
YANLIŞ: Add authorization roles as admin and user, so that people can get roles in other controllers and admins can assign roles to other users.

DOĞRU: Add authorization roles as admin and user
```

- Başlıkta emir kipi kullanın

```
YANLIŞ: Geliştiriciler için issue dokümanı ekledim
DOĞRU: Geliştiriciler için issue dokümanı ekle
```

- Başlık cümlesini nokta işareti ile bitirmeyin

```
YANLIŞ: Geliştiriciler için issue dokümanı ekle.
DOĞRU: Geliştiriciler için issue dokümanı ekle
```


# Commit Gövdesi
----------------

- Commit gövdesini satır uzunluklarını (72 karakter) ihlal etmeden dilediğinizce uzun yazabilirsiniz.

- Commit gövdesinde ilgili iş kaydına (varsa) mention yapın ve diğer referansları da belirtin.

```
Lorem ipsum dolor sit amet

Morbi ante magna, ultricies et tortor vel, sensus vitae.
Vestibulum ut rhoncus neque. Praesent quis odio mauris.
Donec at fermentum neque. Mauris in tellus posuere risus.
Felis vitae, porttitor quam. Morbi eget pulvinar mi.
Cras tincidunt fringilla nulla, vitae imperdiet justo
molestie sed. Pellentesque congue metus non dolor magna
aliquam. Morbi vel magna est. Aliquam risus arcu.

Fixes: #9991
Closes: #9992
Revolves: #9993
References: #9994, #9995, #9996
```
