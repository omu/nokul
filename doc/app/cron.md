---
author(s):
  - Emre Can Yılmaz (@ecylmz)
---

Cron
==============

Uygulamada cron görevleri [sidekiq-cron][sidekiq-cron] gem'i ile gerçekleştiriliyor.

Yeni bir cron görevi eklenmek istendiğinde ilgili cron'un bir Rake görevi olmalıdır.
Bu rake görevi `lib/tasks` dizini altında uygun bir yerde konumlandırılmalıdır.
Cron görevi olarak eklemek için `config/schedule.yml` dosyasına aşağıdaki örnekteki gibi ekleme yapılır.

```yml
first_job:
  cron: "* * * * *" # execute at every minute
  class: RakeJob
  queue: high
  args:
    name: fetch:reference
    params:
      - administrative_functions
      - AdministrativeFunction
```

Geliştirme Ortamı
-----------------

Geliştirme ortamında cron'ları denemek için `schedule.yml` dosyasına yukarıdaki gibi ekleme yapabilir ya da konsoldan
aşağıdaki gibi cron eklemesi yapabilirsiniz.

```ruby
k = "AdministrativeFunction"
args = { name: 'fetch:reference', params: [k.tableize, k] }
job = Sidekiq::Cron::Job.new(name: 'Fetch Reference - every min', cron: '* * * * *', class: 'RakeJob', args: args,
  queue: 'high')
job.save
```

Cron görevleri hakkında bilgi almak için:

```ruby
Sidekiq::Cron::Job.all
```

Tüm cron'ları silmek için:

```ruby
Sidekiq::Cron::Job.destroy_all!
```

Daha detaylı bilgi için [sidekiq-cron][sidekiq-cron] sayfasına bakılabilir.

[sidekiq-cron]: https://github.com/ondrejbartas/sidekiq-cron
