# frozen_string_literal: true

event_types = YAML.load_file(Tenant::Path.db.join('event_types.yml'))
progress_bar = ProgressBar.spawn('EventType', event_types.count)
event_types.each do |category, event_types|
  event_types.each do |event_type|
    CalendarEventType.create(name: event_type['title'], identifier: "#{event_type['name']}_#{category}")
  end
  progress_bar&.increment
end
