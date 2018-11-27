# frozen_string_literal: true

event_titles = YAML.load_file(Tenant::Path.db.join('src', 'event_titles.yml'))
event_titles.keys do |key|
  event_titles[key].each do |event|
    CalendarTitle.create(name: event['title'])
  end
end
CalendarType.create(name: 'Lisans - Önlisans')
CalendarType.create(name: 'Yüksek Lisans')
CalendarType.create(name: 'Ali Fuat Başgil Hukuk Fakültesi')
CalendarType.create(name: 'Yabancı Diller Yüksekokulu')
CalendarType.create(name: 'Tıp Fakültesi')
CalendarType.create(name: 'Diş Hekimliği Fakültesi')
CalendarType.create(name: 'Veteriner Fakültesi')
CalendarType.create(name: 'Yaz Dönemi')
CalendarType.create(name: 'Öğrenci')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'active')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
CalendarTitleType.create(type: CalendarType.first, title: CalendarTitle.all.sample, status: 'passive')
AcademicTerm.create(
  year: '2017-2018',
  term: 'spring',
  start_of_term: '05.09.2017',
  end_of_term: '15.06.2018',
  active: true
)
AcademicCalendar.create(
  name: '2017-2018 Eğitim Öğretim Yılı Akademik Takvimi',
  academic_term: AcademicTerm.first,
  calendar_type: CalendarType.first,
  senate_decision_date: '15.06.2017',
  senate_decision_no: '2017/138',
  description: 'Ders kayıtlarının yapabilmesi için katkı payı ve öğrenim ücreti ödemelerinin yapılması gerekmektedir.'
)
AcademicCalendar.create(
  name: '2017-2018 Eğitim Öğretim Yılı Akademik Takvimi',
  academic_term: AcademicTerm.last,
  calendar_type: CalendarType.first,
  senate_decision_date: '12.04.2018',
  senate_decision_no: '2018/112',
  description: ''
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2018-09-18 00:00:00',
  end_date: ''
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2018-12-22 00:00:00',
  end_date: ''
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2018-11-11 00:00:00',
  end_date: '2018-11-19 23:59:59'
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2017-12-25 00:00:00',
  end_date: '2018-01-05 23:59:59'
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2018-01-13 13:27:49',
  end_date: '2018-01-21 13:27:49'
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2017-09-06 00:00:00',
  end_date: '2017-09-12 23:59:59'
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2017-09-13 00:00:00',
  end_date: '2017-09-15 23:59:59'
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2017-09-12 00:00:00',
  end_date: '2017-09-13 23:59:59'
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2017-09-15 00:00:00',
  end_date: ''
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2017-09-18 00:00:00',
  end_date: ''
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2018-02-02 23:59:59',
  end_date: ''
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.all.sample,
  start_date: '2018-01-03 23:59:59',
  end_date: ''
)
