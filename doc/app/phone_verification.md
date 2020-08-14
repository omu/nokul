---
author(s):
  - Emre Can Yılmaz (@ecylmz)
---

Telefon Doğrulama
====

`VerificationService` isimli modül telefon doğrulama işlemlerinde kullanılmaktadır.

Kullanım
--------

- Doğrulama kodu oluşturup göndermek ve denetlemek için aşağıdaki adımlara benzer adımlar gerçekleyin.

```ruby
# Kod gönder
verification = VerificationService.new(mobile_phone: "TELEFON_NUMARASI")
verification.send_code # true ya da false döner. false dönmesi halinde verification.errors ile hata kontrol edilebilir.

# Kodu doğrula
verification = VerificationService.new(mobile_phone: "TELEFON_NUMARASI", code: 'DOĞRULAMA KODU')
verification.verify # true ya da false döner
```

Hata denetimini yapabilmek için kullanacağınız yerde aşağıdaki gibi bir işlev oluşturup çağırabilirsiniz.

```ruby
def send_verification_code
  return true if @verification.send_code

  return false unless errors.merge!(@verification.errors).empty?

  errors.add(:base, I18n.t('.verification.code_can_not_be_send'))
  false
end
```
