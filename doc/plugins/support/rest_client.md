---
author(s):
  - Hüseyin Tekinaslan (@huseyin)
---

`RestClient`
=============

`RestClient` modülü basit bir HTTP ve REST istemcisidir. Arayüzünde aşağıdaki
HTTP metotlarını destekleyen modül metotları bulunur.

- DELETE
- GET
- PATCH
- POST
- PUT

Tüm metotlar prototip olarak şöyle:

```ruby
method(url, headers: {}, payload: nil, **http_options)
```

Genel kullanımı şu şekilde:

```ruby
url = 'http://localhost'

RestClient.get(url)
RestClient.post(url, headers: { foo: 'bar' }, payload: { baz: 'bar' })
```

İstemci, içeride `net/http` kitaplığını kullanır ve bu değiştirilebilir
değildir. Prototipte görünen `http_object`, içteki sarmalanmış olan bu `http`
nesnesine ayar geçirmek için kullanılır. Tipik kullanım senaryosu SSL ayarlarıdır. Geçersiz bir ayar gönderilirse
`RestClient::UnsupportedHTTPOptionError` sınıfıyla birlikte bir hata mesajı
"raise" edilir.

```ruby
require 'openssl'

url = 'https://localhost'
RestClient.get(url, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_PEER)
```

Geçerli HTTP ayarları ve öntanımlı değerleri:

|Option        |Default value              |
|--------------|---------------------------|
|`open_timeout`|`nil`                      |
|`use_ssl`     |`false`                    |
|`verify_mode` |`OpenSSL::SSL::VERIFY_NONE`|

**Not:** Authentication için temel "HTTP Authentication" şeması kullanılmalı.

```ruby
url = 'https://localhost'
RestClient.get(url, headers: { Authorization: 'Bearer <token>' }, use_ssl: true)
```
