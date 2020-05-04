# frozen_string_literal: true

namespace :fix_data do
  desc "Fills evaluation types' identifier field"
  task evaluation_types: :environment do
    EvaluationType.where(identifier: nil).each do |evaluation_type|
      identifier =
        case evaluation_type.name
        when 'Dönem İçi Değerlendirme'
          'mid_term_results_announcement'
        when 'Dönem Sonu Değerlendirme'
          'final_results_announcement'
        when 'Bütünleme Değerlendirme'
          'retake_results_announcement'
        end

      evaluation_type.update(identifier: identifier)
    end
  end
end
