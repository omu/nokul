---
author(s):
  - Emre Can Yılmaz (@ecylmz)
---

Telefon Doğrulama
====

Doğrulama kodu oluşturup göndermek ve denetlemek için aşağıdaki adımlara benzer adımlar gerçekleyin.

- Kod gönder

  ```ruby
  result = Actions::User::Verification::Send.(«telefon numarası»)
  ```

- Gönderilen kodu doğrula

  ```ruby
  result = Actions::User::Verification::Verify.(«telefon numarası», «doğrulama kodu»)
  ```

Her iki işlemin de başarısı `result.ok?` (veya `result.notok?` ile
sorgulanabilir.  Başarısız bir durumda varsa `result.errors` ile hatalar
okunabilir.
