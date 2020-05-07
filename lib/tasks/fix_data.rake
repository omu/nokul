# frozen_string_literal: true

namespace :fix_data do
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
