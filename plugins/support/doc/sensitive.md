---
author: Recai Oktaş
co-author: M. Serhat Dündar
---

`Sensitive`
===========

`Sensitive` modülü Rails uygulama köküne göreceli olarak çözülen dosyalarda
`RAILS_MASTER_KEY` kullanaral şifreleme ve çözme işlemleri yapar. Şifrelenmiş
dosyalarda daima `.enc` uzantısı kullanıldığı varsayılır.

- Şifrelenmemiş bir dosyayı aynı dizinde `.enc` uzantılı bir dosya olarak şifrele:

  ```ruby
  Sensitive.read_write 'db/enc/prospective_students.csv'
  ```

  `db/enc/prospective_students.csv.enc` şifrelenmiş dosyası oluşur.

- Şifrelenmiş olan herhangi bir dosyayı bütün halde oku:

  ```ruby
  Sensitive.read 'db/enc/prospective_students.csv'
  ```

  `db/enc/prospective_students.csv.enc` şifrelenmiş dosyası okunur.

- Şifrelenmiş olan herhangi bir dosyayı satırlar halinde (dizi) oku:

  ```ruby
  Sensitive.readlines 'db/enc/prospective_students.csv'
  ```

  `db/enc/prospective_students.csv.enc` şifrelenmiş dosyası satırlar halinde
  okunur.

- Şifrelenmiş olan herhangi bir dosyayı okuduktan sonra içeriğini şifresiz olarak ayrı bir dosyaya kaydet:

  ```ruby
  File.write('plain-text.md', Sensitive.read('db/encrypted_data/prospective_students.csv'))
  ```

- Şifrelenmemiş bir dizgi ("string") içeriğini şifreleyerek bir dosyaya kaydet:

  ```ruby
  Sensitive.write 'foo.txt', 'şifrelenmemiş içerik' # foo.txt.enc dosyasını oluşturur
  ```

  `foo.txt.enc` şifrelenmiş dosyası oluşturulur.

- Şifrelenmemiş bir dizgi ("string") dizisini satırlar halinde şifreleyerek bir dosyaya kaydet:

  ```ruby
  Sensitive.writelines 'foo.txt', %w[şifrelenmemiş içerik] # foo.txt.enc dosyasını oluşturur
  ```

  `foo.txt.enc` şifrelenmiş dosyası oluşturulur.


Bu modülü kullanmadan önce lütfen aşağıdaki hususları dikkate alın:


- Hassas verileri **tercihen** depoya eklemeyin. Bu mümkün değilse
  `RAILS_MASTER_KEY` ile simetrik şekilde şifreleyerek depoya ekleyin.

- Hassas veriler içeren dosyanın şifrelenmemiş halini kesinlikle depoya
  eklemeyin.

- Şifrelenen dosyaları tercihen tek bir dizinde `.enc` uzantısıyla toplayın.
  Örneğin `db` dizinindeki dosyalar için standart olarak  `db/enc` dizinini
  kullanabilirsiniz.


- Dosyayı şifreledikten sonra şifrelenmemiş dosyayı silerek şifrelenmişi depoya ekleyin.

  ```sh
  rm -f db/enc/students.csv
  git add db/enc/students.csv.enc
  git commit
  ```

- Dosyanın şifrelenmemiş açık hali Git deposuna zaten ekliyse bu dosyayı silmek
  yeterli değildir. Dosyanın özgün haline Git tarihçesinden erişilebilir.
  Şifrelenmemiş içeriği tamamen kaldırmak için [şu
  yöntemi](https://help.github.com/articles/removing-sensitive-data-from-a-repository/)
  izleyin.
