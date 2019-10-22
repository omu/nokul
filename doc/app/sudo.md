---
author(s):
  - İrfan Subaş (@isubas)
---

Sudo
====

Unix sistemlerdeki sudo komutu benzeri, ekstra bir şifre onaylama yöntemiyle
kontroller işlevlerine erişimi kısıtlamak için kullanılan yardımcı metoddur.

Kullanım
--------

```ruby
module Patron
  class RolesController < ApplicationController
    sudo only: %i[new edit destroy]
    #   sudo  # sudo mode enabled for all actions
    #   sudo only: %i[new edit destroy]
    #   sudo only: [:new, :edit] if: :foo?
    #   sudo except: :destroy, timeout: 1.minutes
    #   sudo timeout: 30.minutes # custom timeout definition
    #   sudo **options
    def new
      # ...
    end

    def edit
      # ...
    end
  end
end
```

**sudo** metoduna `options` olarak `before_action` metodunun alabileceği tüm
değerler aktarılabilir. Bu opsiyonlara ek olarak `timeout` opsiyonuyla özel bir
`timeout` değeri belirlenebilir. Belirlenen timeout değeri tüm işlevler için
geçerli olacaktır.

### Yapılandırma

- `Patron::Sudo.enabled` : Sudo mod aktiflik durumu **(default: true)**
- `Patron::Sudo.timeout` : Sudo mod için belirlenen session'ın timeout değeri **(default: 15.minutes)**

### Yardımcı Methodlar

- `reset_sudo_session!` : Sudo mod için belirlenen session değerini resetler.
- `extend_sudo_session!`: Sudo mod için geçerli bir session değeri atar.
