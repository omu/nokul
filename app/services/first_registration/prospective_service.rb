# frozen_string_literal: true

module FirstRegistration
  class ProspectiveService
    def initialize(prospective)
      @prospective = prospective
      @registered  = prospective.registered_user(user)
    end

    def valid?
      [prospective, registered, user].all?(&:valid?)
    end

    def register
      return set_error_messages unless valid?

      user.save
      registered.save
    end

    def error_messages
      registered.errors.messages.merge(user.errors.messages)
    end

    protected

    attr_reader :prospective, :registered

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
        if prospective.attributes.include?(key.to_s)
          prospective.errors.add(key, message.join(''))
        else
          prospective.errors.add(:base, message.join(''))
        end
      end
      false
    end
  end
end
