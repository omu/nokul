# frozen_string_literal: true

module Ldap
  class UserDecorator < SimpleDelegator
    def ldap_roles
      @ldap_roles ||= build_roles.inquiry
    end

    def ldap_gender
      case identity.try(:gender)
      when 'male'   then '1'
      when 'female' then '2'
      when 'other'  then '0'
      else               '9'
      end
    end

    def identity
      @identity ||= identities.user_identity
    end

    delegate :first_name,    to: :identity, allow_nil: true
    delegate :last_name,     to: :identity, allow_nil: true
    delegate :full_name,     to: :identity, allow_nil: true
    delegate :date_of_birth, to: :identity, allow_nil: true

    # TODO: id_number yerine username bilgisi eklenecek
    def username
      id_number
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
      when :student         then students.map(&:unit)
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
