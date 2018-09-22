# Dosya şifreleme

Hassas verileri **tercihen** depoya eklemeyin.  Bu mümkün değilse
`RAILS_MASTER_KEY` ile simetrik şekilde şifreleyerek depoya ekleyin.

### Veri dosyasını şifreleyerek ekle

Depoda `db/encrypted_data/students.csv` dosya yolunda bulunan bir dosyanın
`db/encrypted_data/students.csv.enc` adıyla şifrelenerek depoya eklenmesi için:

- Proje kökündeyken Rails konsoluna gir

  ```sh
  bin/rails console
  ```

- Şifrele

  ```
  > file = 'db/encrypted_data/students.csv'
  > Encrypted::File.write(File.read(file), file)
  ```

- Şifrelenmemiş dosyayı silerek, şifrelenmişi depoya ekle

  ```sh
  rm -f db/encrypted_data/students.csv
  git add db/encrypted_data/students.csv.enc
  git commit
  ```

### Şifrelenmiş dosya işlemleri

Aşağıda listelenen tüm işlemlerde örnek olarak `path/to/file` göreceli dosya
yolu kullanılmıştır.  Göreceli dosya yolları daima Rails uygulama köküne
(`Rails.root`) göre çözülür ve dosyalar öntanımlı davranış olarak `.enc`
uzantısıyla  kaydedilir.  Yani `path/to/file` dosya yolunun dosya sistemindeki
mutlak yolu `Rails.root + '/path/to/file' + '.enc'` olacaktır.

- Dosya içeriğini bütün halde oku (slurp)

  ```ruby
  Encrypted::File.read('path/to/file')
  ```

- Dosyayı satırlar halinde (dizi) oku

  ```ruby
  Encrypted::File.readlines('path/to/file')
  ```

- İçeriği şifreleyerek bir dosyaya yaz

  ```ruby
  Encrypted::File.write(content, 'path/to/file')
  ```

- İçerik satırlarını (dizi) şifreleyerek bir dosyaya yaz

  ```ruby
  Encrypted::File.writelines(lines, 'path/to/file')
  ```

- Şifrelenmiş dosyanın mutlak dosya yolunu öğren

  ```ruby
  Encrypted::File.expand_path('path/to/file')
  ```

- Şifrelenmiş dosyanın var olup olmadığını sorgula

  ```ruby
  Encrypted::File.exist?('path/to/file')
  ```

### Şifreleme ayarları

- Depo dışında bir yerde tutulan şifrelenmiş veriye eriş

  ```ruby
  Encrypted::File.read('/etc/path/to/file')
  ```

  Görüldüğü gibi mutlak dosya yolu kullanıldığında çözümleme yapılmamaktadır.

- Göreceli yol çözümlemesi için Rails uygulama kökü dışında bir dizin kullan

  ```ruby
  Rails.configuration.x.encrypted.root = '/etc/path'
  ```

- Şifrelenmiş dosyalar için `.enc` dışında bir uzantı kullan

  ```ruby
  Rails.configuration.x.encrypted.ext = '.xyz'
  ```

- Şifrelenmiş dosyalarda ilave uzantı olmasın

  ```ruby
  Rails.configuration.x.encrypted.ext = ''
  ```
