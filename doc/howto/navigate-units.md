---
author: M. Serhat Dundar
---

# How To: Navigate Between Units

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

<pre>
Ondokuz Mayıs Üniversitesi [University]
    19 Mayıs Samsun Devlet Konservatuvarı [Academy]
        Müzik Bölümü [Department]
            Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
            Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]
            Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]
        Sahne Sanatları Bölümü [Department]
            Bale Anasanat Dalı [ArtDiscipline]
            Opera Anasanat Dalı [ArtDiscipline]
</pre>

## Navigating Between Units

### all records of a unit type

```ruby
Unit.university.all
Unit.faculty.all
Unit.department.all
```

You can navigate your way between units with `parent`, `root`, `ancestors`, `children`, `siblings`, `subtree` and `descendants` methods of ancestry.

### parent

```ruby
art_discipline = Unit.art_discipline.first # Kompozisyon Ve Orkestra Şefliği Anasanat Dalı
art_discipline.parent
```

will return the parent unit:

<pre>
Ondokuz Mayıs Üniversitesi [University]
    19 Mayıs Samsun Devlet Konservatuvarı [Academy]
        <b>Müzik Bölümü [Department]</b>
            Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
            <i>Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]</i>
            Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]
</pre>

### root

```ruby
art_discipline = Unit.art_discipline.first # Kompozisyon Ve Orkestra Şefliği Anasanat Dalı
art_discipline.root
```

will return the root unit:

<pre>
<b>Ondokuz Mayıs Üniversitesi [University]</b>
    19 Mayıs Samsun Devlet Konservatuvarı [Academy]
        Müzik Bölümü [Department]
            Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
            <i>Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]</i>
            Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]
</pre>

### ancestors

```ruby
art_discipline = Unit.art_discipline.first # Kompozisyon Ve Orkestra Şefliği Anasanat Dalı
art_discipline.ancestors
```

will return an array of parents:

<pre>
<b>Ondokuz Mayıs Üniversitesi [University]</b>
    <b>19 Mayıs Samsun Devlet Konservatuvarı [Academy]</b>
        <b>Müzik Bölümü [Department]</b>
            Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
            <i>Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]</i>
            Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]
</pre>

### children

```ruby
academy = Unit.academy.first # 19 Mayıs Samsun Devlet Konservatuvarı
academy.children
```

will return an array of children:

<pre>
Ondokuz Mayıs Üniversitesi [University]
    <i>19 Mayıs Samsun Devlet Konservatuvarı [Academy]</i>
        <b>Müzik Bölümü [Department]</b>
            Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]
            Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]
            Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]
        <b>Sahne Sanatları Bölümü [Department]</b>
            Bale Anasanat Dalı [ArtDiscipline]
            Opera Anasanat Dalı [ArtDiscipline]
</pre>

### siblings

```ruby
discipline = Unit.find(116) # Geleneksel Türk Müzikleri Anabilim Dalı
discipline.siblings
```

will return an array of siblings:

<pre>
Ondokuz Mayıs Üniversitesi [University]
    19 Mayıs Samsun Devlet Konservatuvarı [Academy]
        Müzik Bölümü [Department]
            <i>Geleneksel Türk Müzikleri Anabilim Dalı [ScienceDiscipline]</i>
            <b>Kompozisyon ve Orkestra Şefliği Anasanat Dalı [ArtDiscipline]</b>
            <b>Üflemeli ve Vurmalı Çalgılar Anasanat Dalı [ArtDiscipline]</b>
        Sahne Sanatları Bölümü [Department]
            Bale Anasanat Dalı [ArtDiscipline]
            Opera Anasanat Dalı [ArtDiscipline]
</pre>

### subtree

```ruby
academy = Unit.academy.first # 19 Mayıs Samsun Devlet Konservatuvarı
academy.subtree
```

will return an array of sub-units, **including** the main unit:

<pre>
Ondokuz Mayıs Üniversitesi [University]
    <i><b>19 Mayıs Samsun Devlet Konservatuvarı</i></b> [Academy]
        <b>Müzik Bölümü</b> [Department]
            <b>Geleneksel Türk Müzikleri Anabilim Dalı</b> [ScienceDiscipline]
            <b>Kompozisyon ve Orkestra Şefliği Anasanat Dalı</b> [ArtDiscipline]
            <b>Üflemeli ve Vurmalı Çalgılar Anasanat Dalı</b> [ArtDiscipline]
        <b>Sahne Sanatları Bölümü</b> [Department]
            <b>Bale Anasanat Dalı</b> [ArtDiscipline]
            <b>Opera Anasanat Dalı</b> [ArtDiscipline]
</pre>

### descendants

```ruby
academy = Unit.academy.first # 19 Mayıs Samsun Devlet Konservatuvarı
academy.descendants
```

will return an array of sub-units, **exluding** the main unit:

<pre>
Ondokuz Mayıs Üniversitesi [University]
    <i>19 Mayıs Samsun Devlet Konservatuvarı</i> [Academy]
        <b>Müzik Bölümü</b> [Department]
            <b>Geleneksel Türk Müzikleri Anabilim Dalı</b> [ScienceDiscipline]
            <b>Kompozisyon ve Orkestra Şefliği Anasanat Dalı</b> [ArtDiscipline]
            <b>Üflemeli ve Vurmalı Çalgılar Anasanat Dalı</b> [ArtDiscipline]
        <b>Sahne Sanatları Bölümü</b> [Department]
            <b>Bale Anasanat Dalı</b> [ArtDiscipline]
            <b>Opera Anasanat Dalı</b> [ArtDiscipline]
</pre>

See [ancestry](https://github.com/stefankroes/ancestry) document for more details and other helpers.

### all sub-units

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
