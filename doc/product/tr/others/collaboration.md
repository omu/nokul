# İşbirliği
- [İşbirliği](#i̇şbirliği)
    - [İsimlendirmeler](#i̇simlendirmeler)
        - [Asset isimlendirme](#asset-isimlendirme)
            - [Asset isimlendirme kuralı](#asset-isimlendirme-kuralı)
                - [Prefix](#prefix)
                - [Sort number](#sort-number)
                - [Name](#name)
                - [Extension](#extension)

## İsimlendirmeler
### Asset isimlendirme
Dokumanlarda kullanılan medyaları (assets) genel olarak 4 grupta sınıflandırıyoruz;

1. Diagramlar
1. Ekran alıntısı
1. Mockup / Wireframe görseli
1. Gruplandırılmamış

Dokumanlar geliştirildikçe yeni asset grupları ortaya çıkabiliyor. Bazı asset gruplarına çok az ihtiyacımız olurken, bazıları sürekli kullandığımız gruplar olabiliyor. Bu yüzden her asset grubu için ayrı ayrı dizinler oluşturmaktansa, [tek asset dizini](/doc/assets) içerisinde anlaşılır ve sabit bir isimlendirme kuralıyla (naming convention) asset'leri isimlendiriyoruz.

#### Asset isimlendirme kuralı

```$PREFIX-$SORTNUMBER[-$NAME].$EXTENSION```

Asset isimlendirmesi 4 temel değişkenden oluşuyor. Doküman yazarken oldukça fazla asset üretebiliyoruz ve her asset için bir isim uydurmak çoğu zaman bizi zorluyor. Bazen saçma isimler de üretebiliyoruz. Bunun önüne geçmek için aşağıda belirtilen değişkenlerden sadece ilk ikisini (`prefix` ve `sort number`) zorunlu tuttuk. Böylece gerekli görmüyorsanız, ya da benzer birden çok asset'e sahipseniz `name` değişkenini kullanmak zorunda değilsiniz.

1. [Prefix](#prefix) (Zorunlu)
1. [Sort Number](#sort-number) (Zorunlu)
1. [Name](#name)
1. [Extension](#extension)



##### Prefix
Tüm asset'lerimiz [aynı dizinde](/doc/assets) tutuluyor. Asset'lerin yönetimini kolaylaştırması için her asset grubuna bir prefix atadık. Örneğin diagramlar için DG prefix'ini kullanıyoruz.

Asset Grubu | Prefix
|---|---|
Diagramlar | DG
Ekran alıntısı | SS
Mockup / Wireframe görseli | WF
Gruplandırılmamış | UC

##### Sort number
Her asset için kendi asset grubundaki sırası belirtecek bir sıra numarası veriyoruz. Aşağıdaki gibi bir asset dizinimiz olduğunu varsayalım;

```
/
├── doc
|   ├── product
|   |   ├── assets
|   |   |   ├── DG-00001.svg
|   |   |   ├── DG-00002.svg
|   |   |   ├── SS-00001.png
|   |   |   ├── WF-00001.png
|   |   |   ├── WF-00002.png
|   |   |   └── WF-00003.png
```

Böyle bir durumda yeni bir diagram eklemek istediğimizde `DG-00003.svg` olarak isimlendirmeliyiz. Aynı şekilde yeni gelecek bir wireframe `WF-00004.png` olarak isimlendirilmeli.

Farkettiyseniz burada `sort number` olarak 5 haneli (5 digit) bir yapı kullanıyoruz. Dosya isimlerine göre sıralama yapılırken, string sıralaması yapılacağı için `sort number`'ın hane sayısını sabitledik. Eğer sabitlemeseydik; `DG-10.svg`, `DG-2.svg`'den önce gelecekti. Çünkü 1 karakteri, 2'den önce gelir :) Ancak `DG-00010`, `DG-00002`'den sonra gelecektir.

Aslında öngörümüz; `sort number` için 4 hanenin yeterli olacağı yönünde. Ancak aksi bir durumda değişikliğin zor olacağından ve yeterince zamanımızın olmamasından (ve tabiki tembelligimizin de bunda payı var) dolayı bir hane fazla kullanmak istedik.

##### Name
`name` değişkeni [Kebab Case][1] formatında (bu naming convention için farklı isimler de kullanılıyor ama kebap sevdiğimiz için biz bunu tercih ediyoruz. Ayrıca kim kebap sevmezki!) yazılmalıdır. Örneğin: `DG-0001-kebab-case.png`

##### Extension
`extension` değişkeni tamamen dosyanın formatıyla ilgili. Burada herhangi bir kısatlamamız yok. Web browser'ların görüntüleye bildiği her türlü dosya formatını asset olarak saklayabiliriz. Ancak, dosyanın gerçek formatıyla `extension` tabiki uyumlu olmalı.

Parçalı dosyalardan oluşan özel bir format kullanılıyorsa (şuana kadar denk gelmediğimiz için üzerinde düşünmedik) bu durumu issue olarak açıp konuşmamız gerekir.


[1]: https://en.wikipedia.org/wiki/Kebab_case