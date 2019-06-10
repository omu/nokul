---
author(s):
  - M. Serhat Dundar (@msdundar)
---

How To: Navigate and Assign Users
=================================

**Some variables to use later:**

```ruby
bote_yl = Unit.find_by(yoksis_id: 244883)
bote_department = Unit.find_by(yoksis_id: 122154)
institute = Unit.find_by(yoksis_id: 174846)
ce_department = Unit.find_by(yoksis_id: 122184)
baum = Unit.find_by(yoksis_id: 327269)
uzem = Unit.find_by(yoksis_id: 169431)
```

**Create users:**

```ruby
serhat = User.create!(id_number: 12345678912, email: 'msdundars@gmail.com', password: '123456', password_confirmation: '123456')
roktas = User.create!(id_number: 98765432198, email: 'roktas@gmail.com', password: '123456', password_confirmation: '123456')
```

**Create studentship and employee:**

```ruby
serhat_ceit_student = Student.create(student_number: '1234567', user: serhat, unit: bote_yl)
serhat_ra = Employee.create(title: Title.find_by(code: 1590), user: serhat)
roktas_dr = Employee.create(title: Title.find_by(code: 1567), user: roktas)
```

**Add some duties:**

```ruby
serhat_ra.duties.create(temporary: false, start_date: '01.01.2015', unit: institute)
serhat_ra.duties.create(temporary: true, start_date: '01.01.2015', end_date: '01.01.2017', unit: bote_department)
serhat_ra.duties.create(temporary: true, start_date: '01.01.2017', end_date: '01.01.2019', unit: uzem)

roktas_dr.duties.create(temporary: false, start_date: '01.01.2005', unit: ce_department)
roktas_dr.duties.create(temporary: true, start_date: '01.01.2017', unit: uzem)
roktas_dr.duties.create(temporary: true, start_date: '01.01.2017', unit: baum)
```

**Add some positions:**

```ruby
mudur_yard = AdministrativeFunction.find_by(code: 29)
roktas.duties.first.positions.create(administrative_function: mudur_yard)
```

**All valid queries:**

```ruby
serhat.duties # tüm görevler
serhat.duties.tenure # kadrolu ifa ettiği tüm görevler
serhat.duties.temporary # geçici görevlendirmeyle ifa ettiği tüm görevler
serhat.units # görevli olduğu tüm birimler
serhat.units.department # görevli olduğu tüm bölümler
serhat.units.research_centers # görevli olduğu araştırma merkezleri
serhat.employees # tüm personellikleri
serhat.employees.active # aktif tüm personellikleri
uzem.employees # uzem'in tüm personelleri
uzem.eployees.active # uzem'in aktif tüm personelleri
uzem.students # uzem'in tüm öğrencileri
bote_yl.students # böte yüksek lisans'ın tüm öğrencileri
serhat.administrative_functions # tüm yönetici pozisyonları
uzem.administrative_functions # uzem'de bulunan tüm yönetici pozisyonları
```
