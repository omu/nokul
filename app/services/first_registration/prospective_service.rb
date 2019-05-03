# frozen_string_literal: true

module FirstRegistration
  class ProspectiveService
    def initialize(prospective)
      @prospective = prospective
      @concrete    = prospective.build_concrete_user(user)
    end

    def valid?
      [prospective, concrete, user].all?(&:valid?)
    end

    def register
      return set_error_messages unless valid?

      user.save
      concrete.save
    end

    def error_messages
      concrete.errors.messages.merge(user.errors.messages)
    end

    protected

    attr_reader :prospective, :concrete

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
      error_messages.each do |key, message|
        prospective.errors.add(key, message.join(''))
      end
      false
    end
  end
end
