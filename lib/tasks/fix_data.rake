# frozen_string_literal: true

namespace :fix_data do
  desc 'Adds new calendar event type'
  task new_calendar_event_type: :environment do
    CalendarEventType.create(
      name:       'Açılan Ders Ekle/Çıkar İşlemleri',
      identifier: 'add_drop_available_courses',
      category:   'courses'
    )
  end
end
