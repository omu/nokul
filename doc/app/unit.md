---
author(s):
  - M. Serhat Dundar (@msdundar)
---

Units
=====

Navigating Between Units
------------------------

`Unit` model uses [ancestry](https://github.com/stefankroes/ancestry).

**Children classes of Unit model** can be listed as follows:

- InterdisciplinaryDiscipline
- InterdisciplinaryDoctoralProgram
- Academy
- Rectorship
- VocationalSchool
- Institute
- Faculty
- UndergraduateProgram
- InterdisciplinaryMasterProgram
- ArtDiscipline
- Discipline
- Department
- ResearchCenter
- DoctoralProgram
- MasterProgram
- ScienceDiscipline
- ProficiencyInArtProgram
- University

Here is a tree-like unit structure:

- **Ondokuz Mayıs Üniversitesi** [University]
  + **19 Mayıs Samsun Devlet Konservatuvarı** [Academy]
    - Müzik Bölümü [Department]
    - Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
    - Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]
    - Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]
  + **Sahne Sanatları Bölümü** [Department]
    - Bale Anasanat Dalı [ArtDiscipline]
    - Opera Anasanat Dalı [ArtDiscipline]

### All records of a unit type

```ruby
Unit.university.all
Unit.faculty.all
Unit.department.all
```

You can navigate your way between units with `parent`, `root`, `ancestors`, `children`, `siblings`, `subtree` and
`descendants` methods of ancestry.

### Parent

```ruby
art_discipline = Unit.art_discipline.first # Kompozisyon Ve Orkestra Şefliği Anasanat Dalı
art_discipline.parent
```

will return the parent unit:

- **Ondokuz Mayıs Üniversitesi** [University]
  + **19 Mayıs Samsun Devlet Konservatuvarı** [Academy]
    - **Müzik Bölümü** [Department]
      + Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
      + Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]
      + Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]

### Root

```ruby
art_discipline = Unit.art_discipline.first # Kompozisyon Ve Orkestra Şefliği Anasanat Dalı
art_discipline.root
```

will return the root unit:

- **Ondokuz Mayıs Üniversitesi** [University]
  + **19 Mayıs Samsun Devlet Konservatuvarı** [Academy]
    - **Müzik Bölümü** [Department]
      + Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
      + Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]
      + Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]

### Ancestors

```ruby
art_discipline = Unit.art_discipline.first # Kompozisyon Ve Orkestra Şefliği Anasanat Dalı
art_discipline.ancestors
```

will return an array of parents:

- **Ondokuz Mayıs Üniversitesi** [University]
  + **19 Mayıs Samsun Devlet Konservatuvarı** [Academy]
    - **Müzik Bölümü** [Department]
      + Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
      + Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]
      + Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]

### Children

```ruby
academy = Unit.academy.first # 19 Mayıs Samsun Devlet Konservatuvarı
academy.children
```

will return an array of children:

- **Ondokuz Mayıs Üniversitesi** [University]
  + **19 Mayıs Samsun Devlet Konservatuvarı** [Academy]
    - **Müzik Bölümü** [Department]
      + Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
      + Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]
      + Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]
    - **Sahne Sanatları Bölümü** [Department]
      + Bale Anasanat Dalı [ArtDiscipline]
      + Opera Anasanat Dalı [ArtDiscipline]

### Siblings

```ruby
discipline = Unit.find(116) # Geleneksel Türk Müzikleri Anabilim Dalı
discipline.siblings
```

will return an array of siblings:

- **Ondokuz Mayıs Üniversitesi** [University]
  + **19 Mayıs Samsun Devlet Konservatuvarı** [Academy]
    - **Müzik Bölümü** [Department]
      + Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
      + Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]
      + Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]
    - **Sahne Sanatları Bölümü** [Department]
      + Bale Anasanat Dalı [ArtDiscipline]
      + Opera Anasanat Dalı [ArtDiscipline]

### Subtree

```ruby
academy = Unit.academy.first # 19 Mayıs Samsun Devlet Konservatuvarı
academy.subtree
```

will return an array of sub-units, **including** the main unit:

- Ondokuz Mayıs Üniversitesi [University]
  + *19 Mayıs Samsun Devlet Konservatuvarı* [Academy]
    - **Müzik Bölümü** [Department]
    - **Geleneksel Türk Müzikleri Anabilim Dalı** [ScienceDiscipline]
    - **Kompozisyon ve Orkestra Şefliği Anasanat Dalı** [ArtDiscipline]
    - **Üflemeli ve Vurmalı Çalgılar Anasanat Dalı** [ArtDiscipline]
  + *Sahne Sanatları Bölümü* [Department]
    - **Bale Anasanat Dalı** [ArtDiscipline]
    - **Opera Anasanat Dalı** [ArtDiscipline]

### Descendants

```ruby
academy = Unit.academy.first # 19 Mayıs Samsun Devlet Konservatuvarı
academy.descendants
```

will return an array of sub-units, **exluding** the main unit:

- Ondokuz Mayıs Üniversitesi [University]
  + *19 Mayıs Samsun Devlet Konservatuvarı* [Academy]
    - **Müzik Bölümü** [Department]
    - **Geleneksel Türk Müzikleri Anabilim Dalı** [ScienceDiscipline]
    - **Kompozisyon ve Orkestra Şefliği Anasanat Dalı** [ArtDiscipline]
    - **Üflemeli ve Vurmalı Çalgılar Anasanat Dalı** [ArtDiscipline]
  + *Sahne Sanatları Bölümü* [Department]
    - **Bale Anasanat Dalı** [ArtDiscipline]
    - **Opera Anasanat Dalı** [ArtDiscipline]

See [ancestry](https://github.com/stefankroes/ancestry) document for more details and other helpers.

### All sub-units

Return **all sub-units** (faculties, departments, disciplines, everything) of another unit:

```ruby
Unit.university.first.descendants.units
Unit.faculty.last.descendants.departments
Unit.department.last.descendants.undergraduate_programs
```

You can also directly communicate with children classes such as Faculty and Department:

```ruby
Unit.faculty
Unit.research_center.find_by(yoksis_id: 12345)
Unit.department.find_by(status: 1)
```
