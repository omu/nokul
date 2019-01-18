# frozen_string_literal: true

event_types = YAML.load_file Tenant.root.join('db', 'static', 'event_types.yml')

progress_bar = ProgressBar.spawn('EventType', event_types.count)
event_types.each do |category, event_type|
  event_type.each do |type|
    CalendarEventType.create(
      name: type['name'],
      identifier: "#{type['identifier']}_#{category}",
      category: category.to_s
    )
  end
  progress_bar&.increment
end

calendars = [
  {
    name: 'Lisans-Önlisans Akademik Takvimi',
    senate_decision_date: '21.06.2018',
    senate_decision_no: '2018/191',
    timezone: 'Istanbul',
    academic_term: AcademicTerm.first
  },
  {
    name: 'Lisansüstü Akademik Takvimi',
    senate_decision_date: '21.06.2018',
    senate_decision_no: '2018/191',
    timezone: 'Istanbul',
    academic_term: AcademicTerm.first
  },
  {
    name: 'Diş Hekimliği Fakültesi Akademik Takvimi',
    senate_decision_date: '21.06.2018',
    senate_decision_no: '2018/191',
    timezone: 'Istanbul',
    academic_term: AcademicTerm.first
  },
  {
    name: ' Ali Fuat Başgil Hukuk Fakültesi Akademik Takvimi',
    senate_decision_date: '21.06.2018',
    senate_decision_no: '2018/191',
    timezone: 'Istanbul',
    academic_term: AcademicTerm.first
  },
  {
    name: 'Yabancı Diller Yüksekokulu Akademik Takvimi',
    senate_decision_date: '21.06.2018',
    senate_decision_no: '2018/191',
    timezone: 'Istanbul',
    academic_term: AcademicTerm.first
  },
  {
    name: 'UZEM Lisansüstü Akademik Takvimi',
    senate_decision_date: '21.06.2018',
    senate_decision_no: '2018/191',
    timezone: 'Istanbul',
    academic_term: AcademicTerm.first
  }
]

Calendar.create(calendars)

calendar_events = [
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'major_and_minor_applications'),
    start_time: '2018-09-10 08:00:00',
    end_time: '2018-09-14 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'major_and_minor_application_results_announcement'),
    start_time: '2018-09-17 08:00:00',
    end_time: '2018-09-19 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'foreign_language_proficiency_exams'),
    start_time: '2018-09-18 08:00:00',
    end_time: '2018-09-19 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'foreign_language_proficiency_results_announcement'),
    start_time: '2018-09-21 08:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'preparatory_class_grading_exams'),
    start_time: '2018-09-24 08:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'online_course_registrations'),
    start_time: '2018-09-17 08:00:00',
    end_time: '2018-09-26 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'start_and_end_of_courses'),
    start_time: '2018-09-24 08:00:00',
    end_time: '2018-11-28 08:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'foreign_language_exemption_exams'),
    start_time: '2018-09-26 08:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'transfer_for_elective_courses_advisor'),
    start_time: '2018-09-24 08:00:00',
    end_time: '2018-10-01 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'excused_course_registrations'),
    start_time: '2018-09-24 08:00:00',
    end_time: '2018-10-19 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'mid_term_exams'),
    start_time: '2018-11-17 08:00:00',
    end_time: '2018-11-25 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'final_exams'),
    start_time: '2018-12-31 08:00:00',
    end_time: '2019-01-11 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'final_results_announcement'),
    start_time: '2018-12-31 08:00:00',
    end_time: '2019-01-16 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'retake_exams'),
    start_time: '2019-01-19 08:00:00',
    end_time: '2019-01-27 17:00:00',
    timezone: 'Istanbul',
    visible: true
  },
  {
    calendar_event_type: CalendarEventType.find_by(identifier: 'retake_results_announcement'),
    start_time: '2019-01-19 08:00:00',
    end_time: '2019-01-30 17:00:00',
    timezone: 'Istanbul',
    visible: true
  }
]

calendar = Calendar.find_by(name: 'Lisans-Önlisans Akademik Takvimi')
calendar.calendar_events.create(calendar_events)
