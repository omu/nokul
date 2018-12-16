# frozen_string_literal: true

event_titles = YAML.load_file(Tenant::Path.db.join('event_titles.yml'))
progress_bar = ProgressBar.spawn('CalendarTitle', event_titles.count)
event_titles.each do |category, events|
  events.each do |event|
    CalendarTitle.create(name: event['title'], identifier: "#{category}_#{event['name']}")
  end
  progress_bar.increment
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

CalendarTitle.find_each do |title|
  CalendarTitleType.create(type: CalendarType.first, title: title, active: true)
end

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
  academic_term: AcademicTerm.second,
  calendar_type: CalendarType.first,
  senate_decision_date: '12.04.2018',
  senate_decision_no: '2018/112',
  description: ''
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :course_add_and_drop),
  start_date: '2018-09-18 00:00:00',
  end_date: '2018-09-25 00:00:00',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :course_end_date),
  start_date: '2018-12-22 00:00:00',
  end_date: '2018-12-26 00:00:00',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :course_registration),
  start_date: '2018-11-11 00:00:00',
  end_date: '2018-11-19 23:59:59',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :exam_makeup_date),
  start_date: '2018-12-25 00:00:00',
  end_date: '2019-01-05 23:59:59',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :exam_final_date),
  start_date: '2018-10-13 13:27:49',
  end_date: '2018-10-21 13:27:49',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :exam_foreign_language_proficiency),
  start_date: '2018-09-06 00:00:00',
  end_date: '2018-09-12 23:59:59',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :exam_grading),
  start_date: '2018-09-13 00:00:00',
  end_date: '2018-09-15 23:59:59',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :exam_midterm_date),
  start_date: '2018-09-12 00:00:00',
  end_date: '2018-09-13 23:59:59',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :grade_makeup_excuse),
  start_date: '2018-09-15 00:00:00',
  end_date: '2018-09-18 00:00:00',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :grade_midterm_excuse),
  start_date: '2018-09-18 00:00:00',
  end_date: '2018-09-26 00:00:00',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :grade_submission_final_date),
  start_date: '2018-10-02 00:00:00',
  end_date: '2018-10-09 00:00:00',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :grade_submission_makeup_date),
  start_date: '2018-11-03 00:00:00',
  end_date: '2018-11-09 00:00:00',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
CalendarEvent.create(
  academic_calendar: AcademicCalendar.first,
  calendar_title: CalendarTitle.find_by(identifier: :grade_submission_single_course),
  start_date: '2019-01-03 00:00:00',
  end_date: '2019-01-09 00:00:00',
  calendar_type: CalendarType.first,
  academic_term: AcademicTerm.first
)
