# frozen_string_literal: true

module Actions
  module ProspectiveStudent
    class Upsert
      attr_reader :params

      def initialize(params, academic_term: AcademicTerm.current, type: :bulk)
        @params = params.merge(
          system_register_type: type,
          academic_term_id:     academic_term&.id,
          expiry_date:          academic_term&.end_of_term
        )
      end

      private_class_method :new

      class << self
        def call(params, academic_term: AcademicTerm.current, type: :bulk)
          new(params, academic_term: academic_term, type: type).call
        end
      end

      def call
        prepare_params

        prospective_student = ::ProspectiveStudent.find_or_initialize_by(
          params.slice(:id_number, :academic_term_id)
        )
        prospective_student.assign_attributes(params)

        prospective_student.save!
      end

      private

      def prepare_params
        set_unit
        set_language
        set_obs_registered_program
        set_student_disability_type
        set_high_school_type
        set_student_entrance_type
        clean
      end

      def content_valid_for?(key, collection: ['null'])
        return false unless params.key?(key) && params[key].present? && collection.exclude?(params[key])

        true
      end

      def set_unit
        params[:unit_id] = Unit.find_by(osym_id: params[:program_code])&.id
      end

      def set_language
        return unless content_valid_for?(:language)

        params[:language_id] = Language.find_by(name: language.capitalize_turkish)&.id
      end

      def set_obs_registered_program
        return unless !params.fetch(:obs_status) &&
                      content_valid_for?(:current_program, collection: %w[O null])

        params[:obs_registered_program] = Xokul::Yoksis::Units.unit_name_from_id(
          unit_id: params[:current_program]
        )[:long_name]
      end

      def set_student_disability_type
        return unless content_valid_for?(:student_disability_type)

        params[:student_disability_type_id] = StudentDisabilityType.find_by(
          code: params[:student_disability_type]
        )&.id
      end

      def set_high_school_type
        return unless content_valid_for?(:high_school_type)

        params[:high_school_type_id] = HighSchoolType.find_by(code: params[:high_school_type])&.id
      end

      def set_student_entrance_type
        # TODO: will be dynamic in the future
        params[:student_entrance_type_id] = StudentEntranceType.find_by(code: 1)&.id
      end

      def clean
        attributes = ::ProspectiveStudent.attribute_names

        params.each_key do |key|
          params.delete(key) unless attributes.include?(key.to_s)
        end
      end
    end
  end
end
