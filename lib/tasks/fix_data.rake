# frozen_string_literal: true

namespace :fix_data do
  desc "Corrects the misspelling in calendar event types identifier field"
  task calendar_event_types: :environment do
    CalendarEventType.where("identifier like ?", "%mid_term%").each do |event_type|
      corrected_identifier = event_type.identifier.gsub('mid_term', 'midterm')
      event_type.update(identifier: corrected_identifier)
    end
  end

  desc "Fills evaluation types' identifier field"
  task evaluation_types: :environment do
    EvaluationType.all.each do |evaluation_type|
      identifier =
        case evaluation_type.name
        when 'Dönem İçi Değerlendirme'
          'midterm'
        when 'Dönem Sonu Değerlendirme'
          'final'
        when 'Bütünleme Değerlendirme'
          'retake'
        end

      evaluation_type.update(identifier: identifier)
    end
  end
end
