`RestClient`
=============

`RestClient` modülü basit bir HTTP ve REST istemcisidir. Arayüzünde aşağıdaki
HTTP metotlarını destekleyen modül metotları bulundurur.

- GET
- DELETE
- PATCH
- POST
- PUT

Tüm metotlar prototip olarak şöyledir:

```ruby
method(url, header: {}, payload: {}, **http_options)
```

Genel kullanımı şu şekilde:

```ruby
url = 'http://localhost'

RestClient.get(url)
RestClient.post(url, header: { foo: 'bar' }, payload: { baz: 'bar' })
```

İstemci, içeride `net/http` kitaplığını kullanır ve bu değiştirilebilir
değildir. Prototipte görülen `http_object`, içeride sarmalanmış olan bu `http`
nesnesine ayar geçirmek için kullanılır. Tipik kullanım senaryosu SSL ayarlarıdır.

```ruby
require 'openssl'

url = 'https://localhost'
RestClient.get(url, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_PEER)
```

**Not:** Authentication için temel "HTTP Authentication" şemasını kullanılmalı.

```ruby
url = 'https://localhost'
RestClient.get(url, header: { Authorization: 'Bearer <token>' }, use_ssl: true)
```
