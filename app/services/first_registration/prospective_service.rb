# frozen_string_literal: true

module FirstRegistration
  class ProspectiveService
    attr_reader :prospective

    def initialize(prospective)
      @prospective = prospective
      extend "FirstRegistration::#{@prospective.class.name}Service".safe_constantize
    end

    private

    def user
      @user ||= begin
        object = User.find_or_initialize_by(id_number: prospective.id_number)

        unless User.exists?(id_number: prospective.id_number)
          object.assign_attributes(email: prospective.email,
                                   password: prospective.id_number,
                                   password_confirmation: prospective.id_number)
        end
        object
      end
    end

    def set_error_messages
      user.errors.messages.each do |key, message|
        prospective.errors.add(key, message.join(''))
      end
      false
    end
  end
end
