# frozen_string_literal: true

require_relative 'unit/abbreviation'
require_relative 'unit/rules'
require_relative 'unit/coder'

module Tenant
  class Unit
    include Container.of %i[
      abbreviation
      code
      district_id
      duration
      foet_code
      founded_at
      name
      osym_id
      yoksis_id
      parent_yoksis_id
      detsis_id
      parent_detsis_id
      related_yoksis_id
      unit_instruction_language_id
      unit_instruction_type_id
      unit_status_id
      unit_type_id
      issues
      notes
    ].freeze

    module Predicators
      PREDICATORS = {
        undergraduate_program?: 'Lisans/Önlisans programı',
        distance_education_program?: 'Uzaktan Eğitim programı',
        doctoral_program?: 'Doktora programı',
        masters_program?: 'Yüksek Lisans programı',
        graduate_program?: 'Lisanüstü program',
        program?: 'Program',
        active?: 'Aktif birim',
        passive?: 'Pasif birim',
        live?: 'Yaşayan birim',
        undergraduate_registrable?: 'ÖSYM ile kayıt olunabilen program',
        undergraduate_unregistrable?: 'ÖSYM ile kayıt olunamayan program',
        administrative?: 'İdari birim',
        academic?: 'Akademik birim',
        special?: 'Ne Akademik ne de İdari olan birim'
      }.freeze

      def self.predicators
        PREDICATORS
      end

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
        unit_status_id =~ /[Pp]asif/
      end

      def live?
        active? || passive?
      end

      def undergraduate_registrable?
        undergraduate_program? && osym_id.present?
      end

      def undergraduate_unregistrable?
        undergraduate_program? && osym_id.blank?
      end

      def administrative?
        detsis_id.present?
      end

      def academic?
        yoksis_id.present?
      end

      def special?
        !administrative? && !academic?
      end
    end

    include Predicators
  end

  class Units < Collection
    def self.load
      read_from_yaml_file Tenant.path collection.source
    end

    def self.store(units, **options)
      write_to_yaml_file Tenant.path(collection.source), units, **options
    end

    def list_by(*predicators)
      select do |unit|
        predicators.none? { |predicator| !unit.send(predicator) }
      end
    end
  end
end
