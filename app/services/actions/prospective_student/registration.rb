# frozen_string_literal: true

module Actions
  module ProspectiveStudent
    class Registration
      Error = Class.new(StandardError) do
        attr_accessor :details
      end

      attr_reader :prospective

      def initialize(prospective)
        @prospective = prospective
      end

      class << self
        def call(prospective)
          new(prospective).call
        end
      end

      def call
        valid!

        ActiveRecord::Base.transaction do
          user.save!
          student.save!
          registered!
          archived!
          upload_avatar!
        end

        true
      end

      private

      delegate :unit,
               :can_permanently_register?,
               :id_number,
               :email,
               :obs_status,
               :academic_term,
               :student_entrance_type,
               :avatar,
               to: :prospective

      def valid!
        return true if user.valid? && student.valid?

        error         = Error.new 'RecordInvalid'
        error.details = [user.errors.full_messages, student.errors.full_messages].flatten!

        raise error
      end

      def registered!
        prospective.update!(registered: true)
      end

      def archived!
        prospective.update!(archived: true) if user.activated
      end

      def upload_avatar!
        return if avatar.blank?

        file = Tempfile.new(['avatar', '.jpg'])
        file.write(Base64.decode64(avatar).force_encoding('UTF-8'))
        user.avatar.attach(io: file.open, filename: "#{id_number}.jpg")
        file.unlink
      end

      # rubocop:disable Metrics/MethodLength
      def student
        @student ||= Student.new(
          user:                   user,
          unit:                   unit,
          permanently_registered: can_permanently_register?,
          status:                 can_permanently_register? ? :active : :passive,
          student_number:         id_number, # TODO: must be generated
          year:                   1,
          semester:               1,
          entrance_type:          student_entrance_type,
          other_studentship:      !obs_status,
          registration_date:      Time.current,
          registration_term:      academic_term
        )
      end
      # rubocop:enable Metrics/MethodLength

      def user
        @user ||= begin
          User.find_by(id_number: id_number) || User.new(
            id_number:             id_number,
            email:                 email,
            password:              id_number,
            password_confirmation: id_number
          )
        end
      end
    end
  end
end
