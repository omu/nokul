# frozen_string_literal: true

module Activatable
  class ActivationService
    include ActiveModel::Validations

    attr_accessor :id_number,
                  :first_name,
                  :last_name,
                  :date_of_birth,
                  :serial,
                  :serial_no,
                  :document_no,
                  :mobile_phone,
                  :country

    validates :id_number, presence: true, numericality: { only_integer: true }, length: { is: 11 }
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
    validates :serial, allow_blank: true, length: { is: 3 }
    validates :serial_no, allow_blank: true, numericality: { only_integer: true }
    validates :document_no, allow_blank: true, length: { is: 9 }
    validates :mobile_phone, telephone_number: { country: proc { |record| record.country }, types: [:mobile] }
    validates_with ActivationServiceValidator
    validate :must_be_not_activated
    validate :must_be_prospective, unless: :activated?
    validate :must_be_verified_identity, if: :prospective?

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    # rubocop:disable Metrics/MethodLength
    def verified_identity?
      birth_date = Date.strptime(date_of_birth)

      Xokul::Kps::Verification.id_card(
        id_number: id_number,
        first_name: first_name,
        last_name: last_name,
        day_of_birth: birth_date.day,
        month_of_birth: birth_date.month,
        year_of_birth: birth_date.year,
        serial: serial,
        number: serial_no,
        document_number: document_no
      )
    end
    # rubocop:enable Metrics/MethodLength

    def activated?
      User.activated.exists?(id_number: id_number)
    end

    # TODO: prospective_employee için geliştirme yapılmalı.
    def prospective?
      ProspectiveStudent.not_archived.registered.exists?(id_number: id_number)
    end

    def active
      return unless valid?

      process
    rescue StandardError
      errors.add(:base, T18n.t('.account.activations.system_error')) && false
    end

    private

    def process
      prospective = ProspectiveStudent.find_by(id_number: id_number)
      user        = User.find_by(id_number: id_number)

      ProspectiveStudent.transaction do
        prospective.update(archived: true)
        user.update(activated: true, activated_at: Time.zone.now)
      end
    end

    def must_be_not_activated
      return if errors.any?

      errors.add(:base, I18n.t('.account.activations.already_activated')) if activated?
    end

    def must_be_prospective
      return if errors.any?

      errors.add(:base, I18n.t('.account.activations.record_not_found')) unless prospective?
    end

    def must_be_verified_identity
      return if errors.any?

      errors.add(:base, I18n.t('.account.activations.identity_not_verified')) unless verified_identity?
    end
  end
end
