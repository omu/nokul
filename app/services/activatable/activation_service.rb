# frozen_string_literal: true

module Activatable
  class ActivationService
    include ActiveModel::Validations

    attr_accessor :id_number, :first_name, :last_name, :date_of_birth, :serial, :serial_no, :document_no, :mobile_phone,
                  :prospective, :user, :country

    validates :id_number, presence: true, numericality: { only_integer: true }, length: { is: 11 }
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
    validates :serial, allow_blank: true, length: { is: 3 }
    validates :serial_no, allow_blank: true, numericality: { only_integer: true }, length: { is: 6 }
    validates :document_no, allow_blank: true, length: { is: 9 }
    validates :mobile_phone, telephone_number: { country: proc { |record| record.country }, types: [:mobile] }
    validates_with ActivationServiceValidator
    validate :must_be_prospective
    validate :check_identity, if: :prospective?

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    # rubocop:disable Metrics/MethodLength
    def verified_identity?
      Xokul::Kps::Verification.id_card(
        id_number: @id_number,
        first_name: @first_name,
        last_name: @last_name,
        day_of_birth: Date.strptime(@date_of_birth).day,
        month_of_birth: Date.strptime(@date_of_birth).month,
        year_of_birth: Date.strptime(@date_of_birth).year,
        serial: @serial,
        number: @serial_no,
        document_number: @document_no
      )
    end
    # rubocop:enable Metrics/MethodLength

    # TODO: prospective_employee için geliştirme yapılmalı.
    def prospective?
      ProspectiveStudent.not_archived.registered.find_by(id_number: @id_number).present?
    end

    def must_be_prospective
      return if errors.any?

      errors.add(:base, I18n.t('.account.activations.record_not_found')) unless prospective?
    end

    def check_identity
      return if errors.any?

      if verified_identity?
        find_prospective
      else
        errors.add(:base, I18n.t('.account.activations.identity_not_verified'))
      end
    end

    # TODO: prospective_employee için geliştirme yapılmalı.
    def find_prospective
      @prospective = ProspectiveStudent.not_archived.registered.find_by(id_number: @id_number)
      @user = User.find_by(id_number: @id_number)
    end
  end
end
