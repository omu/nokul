---
author: M. Serhat Dundar
---

Konfigürasyon
=============

PostgreSQL'i donanım özelliklerinize göre konfigüre ettiğinizde yoğun yazma-güncelleme işlemi yapan `seed`, `import`,
`fetch` gibi task'ler ciddi oranda hızlanacaktır.

1. Başlıklarda tanımlanan RAM miktarı makinanızın toplam RAM'i değil, PostgreSQL'in kullanabileceği maximum RAM
   kapasitesidir. Aynı durum CPU core sayısı için de geçerlidir.
2. İlgili konfigürasyonlar PostgreSQL >= 10 sürümü gerektir. Daha eski sürümler için `max_parallel_workers` satırını
   kaldırın.

Konfigürasyon Dosyası
---------------------

Ubuntu'da genellikle `/etc/postgresql/$VERSION/main/postgresql.conf` altında. Burada yoksa:

```bash
psql -U postgres
show config_file;
```

ile konumunu görebilirsiniz.

Genel Ayarlar
-------------

Yerel makinanızda sorgu istatistiklerini takip edebilmek için konfigürasyon dosyasının sonuna aşağıdaki satırları
ekleyerek `pg_stat` eklentisini aktive edin:

```bash
shared_preload_libraries = 'pg_stat_statements'
pg_stat_statements.track = all
```

Postgres'i restart edin:

```bash
service postgresql restart
```

Tuning
------

8GB RAM + 2 Core + SSD

```conf
# Postgresql Version: 10 || 11
# OS Type: linux
# Total Memory (RAM): 8 GB
# CPUs num: 2
# Connections num: 200
# Data Storage: ssd

max_connections = 200
shared_buffers = 2GB
effective_cache_size = 6GB
maintenance_work_mem = 512MB
checkpoint_completion_target = 0.7
wal_buffers = 16MB
default_statistics_target = 100
random_page_cost = 1.1
effective_io_concurrency = 200
work_mem = 11MB
min_wal_size = 1GB
max_wal_size = 2GB
max_worker_processes = 2
max_parallel_workers_per_gather = 1
max_parallel_workers = 2
```

Referanslar
-----------

- <https://pgtune.leopard.in.ua/#/>
