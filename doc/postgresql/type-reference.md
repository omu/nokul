---
author: M. Serhat Dundar
---

## Rules

- `foreign_key` türündeki sütunlar için, eğer arada `optional: true` bir ilişki yoksa `null: false` kullanın.

- Referential integrity'yi sağlamanın kolay yollarından biri olarak referans verilen sütuna `foreign_key` constraint'i ekleyin.

  ```ruby
  t.references :unit,
    null: false,
    foreign_key: true
  ```

- Çok sık değişecekleri düşünülmediğinden ve değiştikleri zamanlarda ise durumun manuel yönetimi gerektiğinden, `foreign_key` constraint'leri doğrudan sütuna ekleyin, `CHECK` kullanmayın.
