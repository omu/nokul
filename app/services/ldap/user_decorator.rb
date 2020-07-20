# frozen_string_literal: true

module LDAP
  class UserDecorator < SimpleDelegator
    GENDER = { 'male' => '1', 'female' => '2', 'other' => '0' }.freeze

    def ldap_roles
      @ldap_roles ||= build_roles.inquiry
    end

    def ldap_gender
      GENDER.fetch(identity.try(:gender), '9')
    end

    def identity
      @identity ||= Array(identities.user_identity).first || identities.new
    end

    delegate :country_of_citizenship, to: :identity, allow_nil: true
    delegate :date_of_birth,          to: :identity, allow_nil: true
    delegate :first_name,             to: :identity, allow_nil: true
    delegate :full_name,              to: :identity, allow_nil: true
    delegate :last_name,              to: :identity, allow_nil: true

    # TODO: id_number yerine username bilgisi eklenecek
    def username
      id_number
    end

    def place_of_birth_for_ldap
      [
        identity.try(:city).try(:name),
        identity.country_of_citizenship.try(:name)
      ].compact.join(', ')
    end

    def staff_numbers
      employee? ? employees.active.pluck(:staff_number) : []
    end

    def student_numbers
      student? ? students.active.pluck(:student_number) : []
    end

    def faculty?
      academic?
    end

    def staff?
      employee? && !academic?
    end

    def affiliate?
      !employee? && !student?
    end

    def units_by(role)
      case role
      when :faculty, :staff then duties.active.map(&:unit)
      when :student         then students.active.map(&:unit)
      else                       []
      end
    end

    private

    def build_roles
      roles = []
      roles << :faculty   if faculty?
      roles << :staff     if staff?
      roles << :student   if student?
      roles << :affiliate if affiliate?
      roles
    end
  end
end
