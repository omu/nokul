---
story: Admin olarak derslerde arama yapmak istiyorum
actor: Admin
---

Use Case: Derslerde ara
============

**Preconditions:**

- Dersler sistemde tanımlanmış olmalı.
- Diller sistemde tanımlanmış olmalı.
- Eğitim türleri sistemde tanımlanmış olmalı.

**Not:** Detaylı aramada gereken alanlar:

| Field | Type | Required | Note |
| --- | --- | --- | --- |
| Birim | Multi Select | True | |
| Ders Adı | Text | True | |
| Ders Kodu | Text | True | |
| Eğitim Türü | Multi Select | True | |
| Dil | Multi Select | True | |
| Durumu | Multi Select | True | aktif, pasif, arşiv |