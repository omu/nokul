---
author: Recai Oktaş
co-author: M. Serhat Dündar
---

# Dosya şifreleme

- Hassas verileri **tercihen** depoya eklemeyin. Bu mümkün değilse `RAILS_MASTER_KEY` ile simetrik şekilde şifreleyerek depoya ekleyin.
- Hassas veriler içeren dosyanın şifrelenmemiş halini kesinlikle depoya eklemeyin.
- Şifrelenen dosyalar varsayılan olarak `db/encrypted_data` altına konumlandırılır.
- `encrypt` ve `decrypt` metodlarına verdiğiniz dosya yolunun relative veya absolute olmasının bir önemi yoktur, her ikisi de çalışır.

### Veri dosyasını şifreleyerek ekle
--------------

Şifrelenen dosyalar varsayılan olarak `db/encrypted_data` altına konumlandırılır. `encrypt` ve `decrypt` metodlarına verdiğiniz dosya yolunun relative veya absolute olmasının bir önemi yoktur.

- Uygulama dizininde bulunan herhangi bir dosyayı şifrele:

  ```ruby
  FileEncryptor.encrypt('db/static_data/prospective_students.csv')
  ```

- Uygulama dizini dışında bulunan herhangi bir dosyayı şifrele:

  ```ruby
  FileEncryptor.encrypt('/lib/important_files/foobar.csv')
  ```

- Şifrelenmemiş dosyayı silerek, şifrelenmişi depoya ekle:

  ```sh
  rm -f db/static_data/students.csv
  git add db/encrypted_data/students.csv.enc
  git commit
  ```

### Şifrelenmiş dosya işlemleri
--------------

- Şifrelenmiş olan herhangi bir dosyayı bütün halde oku:

  ```ruby
  FileEncryptor.decrypt('db/encrypted_data/prospective_students.csv.enc')
  ```

- Şifrelenmiş olan herhangi bir dosyayı satırlar halinde (sizi) oku:

  ```ruby
  FileEncryptor.decrypt_lines('db/encrypted_data/prospective_students.csv.enc')
  ```

- Uygulama dizini dışındaki bir dosyayı bütün halde oku:

  ```ruby
  FileEncryptor.decrypt('/lib/important_files/foobar.csv.enc')
  ```
