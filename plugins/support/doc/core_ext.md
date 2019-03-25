---
author: Recai Oktaş
---

Çekirdek eklentileri
====================

`Object`
--------

**`to_yaml_pretty`**

Nesnenin (göreceli olarak daha) güzel biçimli YAML temsilini üretir.

```bash
$ ruby -e 'puts %w[foo bar baz].to_yaml'
---
- foo
- bar
- baz
$ ruby -e 'puts %w[foo bar baz].to_yaml_pretty'
---

- foo

- bar

- baz

```

**`must_be_any_of!(*type_specifications)`**

Nesnenin tipinin verilen argümanlardan en az bir tanesiyle uyumluluğunu
denetleyerek nesnenin yine kendisi döner; eşleştirme yoksa `TypeError`
istisnası üretir.

```ruby
@attr = %w[foo bar].must_be_any_of! [String], String #=> ['foo', 'bar']
@attr = 'foo'.must_be_any_of! [String], String #=> 'foo'
@attr = 'foo'.must_be_any_of! Integer #=> TypeError
@attr = { x: 13 }.must_be_any_of! { Symbol => Integer}, { String => Integer } #=> { x: 13 }
```

`Class`
-------

**`inherited_by_conveying_attributes(*attributes, &block)`**

Miras alma sırasında ata sınıf niteliklerinin çocuk sınıfa kopyalanarak
aktarılmasını sağlar.  İsteğe bağlı olarak verilen bloğu da `inherited` hook'ta
çalıştırır.

```ruby
class Parent
  class_attribute :options, default: {}

  inherited_by_conveying_attributes :options
end

class Child < Parent
  options[:length] = 13
end

Parent.options[:length] #=> nil
Child.options[:length] #=> 13
```

`Array`
-------

**`clip(number_of_last_elements = 1)`**

Diziyi sondan `number_of_last_elements` sayıda elemanı çıkarılmış olarak döner.

```ruby
a = %w[foo bar baz]

a.clip #=> ['foo', 'bar']
a #=> ['foo', 'bar', 'baz']
```

**`join_affixed(**options)`**

Dizgi dizisindeki her elemanı (varsa) `options[:interfix]` ile birleştirerek
başına ve sonuna (varsa) `options[:prefix]` ve `options[:suffix]` ekleyerek
döner.

```ruby
%w[foo bar baz].join_affixed prefix: 'aaa-', interfix: '-', 'suffix: -zzz' #=> 'aaa-foo-bar-baz-zzz'
%w[foo bar baz].join_affixed prefix: 'aaa-' #=> 'aaa-foobarbaz'
```

`Hash`
------

**`to_deep_ostruct`**

Hash'ten derin `OpenStruct` nesnesi döner.

```ruby
config = { x: 13, other: { y: 19 } }.to_deep_ostruct
config.x #=> 13
config.other.y #=> 19
```

`Integer`
---------

**`to_string(length, base = 10)`**

Tamsayıdan soldan gerektiği kadar sıfırla doldurarak verilen uzunlukta bir dizgi
döner.

```ruby
13.to_string 5 #=> '00013'
13.to_string 3, 16 #=> '00D'
```

`String`
--------

**`asciified`**

Türkçe karakterleri ASCII yakınlarıyla değiştirir.

```ruby
'ışğüöçİ'.asciified #=> 'isguocI'
```

**`abbreviation`**

Dizgiden kısaltma üretir.

```ruby
'fener bahçe'.abbreviation #=> 'FB'
```

**`capitalize_turkish`**

Türkçe kurallarına uygun olarak ilk harfleri büyütür.

```ruby
'fener bahçe istanbul'.capitalize_turkish #=> 'Fener Bahçe İstanbul'

```

**`capitalize_turkish_with_parenthesized`**

Türkçe kurallarına uygun olarak, parantez içini de dikkate alarak ilk harfleri büyütür.

```ruby
'fener bahçe (istanbul)'.capitalize_turkish_with_parenthesized #=> 'Fener Bahçe (İstanbul)'
```

**`inside_offensives?`**

Dizginin nahoş olup olmadığını döner. (Kelime listesi için `data` dizinine bakın.)

```ruby
'salak'.inside_offensives? #=> true
```

**`inside_reserved?`**

Dizginin rezerve edilmiş bir kelime olup olmadığını döner. (Kelime listesi için
`data` dizinine bakın.)

```ruby
'day'.inside_reserved? #=> true
```

**`inside_abbreviations?`**

Dizginin bir kısaltma olup olmadığını döner. (Kelime listesi için `data`
dizinine bakın.)

```ruby
'KKTC'.inside_abbreviations? #=> true
```

**`inside_conjunctions?`**

Dizginin bir bağlaç olup olmadığını döner. (Kelime listesi için `data` dizinine
bakın.)

```ruby
'veya'.inside_conjunctions? #=> true
```

`SecureRandom`
--------------

**`random_number_string(length, base = 10)`**

Verilen uzunluğa karşı düşen sayı aralığında rastgele bir tamsayı üretip aynı
uzunlukta bir dizgi döner. (Üretilen tamsayı `0 <= rastgele < base**length`
koşulunu sağlar.)

```ruby
SecureRandom.random_number_string(5) #=> 00023
SecureRandom.random_number_string(5, 16) #=> 0AB1F
```
