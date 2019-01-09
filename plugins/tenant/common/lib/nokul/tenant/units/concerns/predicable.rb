# frozen_string_literal: true

module Nokul
  module Tenant
    module Units
      module Concerns
        module Predicable
          extend ActiveSupport::Concern

          def undergraduate_program?
            unit_type_id =~ %r{[Öö]nlisans/[Ll]isans +[Pp]rogram[ı]?}
          end

          def doctoral_program?
            unit_type_id =~ /[Dd]oktora +[Pp]rogram[ı]?/
          end

          def masters_program?
            unit_type_id =~ /[Yy]üksek +[Ll]isans +[Pp]rogram[ı]?/
          end

          def graduate_program?
            masters_program? || doctoral_program?
          end

          def distance_education_program?
            unit_instruction_type_id =~ /[Uu]zaktan +[Öö]ğretim/
          end

          def program?
            undergraduate_program? || graduate_program?
          end

          def active?
            unit_status_id =~ /[Aa]ktif/
          end

          def passive?
            unit_status_id.blank? || unit_status_id =~ /[Pp]asif/
          end

          def semi_passive?
            unit_status_id.blank? || unit_status_id =~ /[Yy]arı +[Pp]asif/
          end

          def live?
            active? || semi_passive?
          end

          def undergraduate_registrable?
            undergraduate_program? && osym_id.present?
          end

          def undergraduate_unregistrable?
            undergraduate_program? && osym_id.blank?
          end

          def special?
            respond_to?(:uni_id) && uni_id.present?
          end

          def academic?
            respond_to?(:yoksis_id) && yoksis_id.present?
          end

          def administrative?
            respond_to?(:detsis_id) && detsis_id.present?
          end
        end
      end
    end
  end
end
