# Authoring

## Bir Başkasının Çalışmasını Commit'lemek

Bir başkasının çalışmasını herhangi bir sebeple siz commit'liyorsanız, çalışmayı gerçekleştiren kişi ilgili commit'lerde author olarak atanmalıdır:

```
git commit --author="John Doe <john@doe.org>"
```

## Ortaklaşa Yazılan Dokümanlar

Ortaklaşa yazılan herhangi bir dokümanı commit'lerken markdown dosyasına meta veri olarak author ve co-author bilgisi girilmelidir. Örneğin:

```
---
author: Recai Oktaş
co-author: M. Serhat Dündar
---
```
