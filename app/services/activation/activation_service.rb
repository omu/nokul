# frozen_string_literal: true

module Activation
  class ActivationService
    include ActiveModel::Validations

    attr_accessor :country,
                  :date_of_birth,
                  :document_no,
                  :first_name,
                  :id_number,
                  :last_name,
                  :mobile_phone,
                  :prospective,
                  :serial,
                  :serial_no,
                  :user

    validates :country, presence: true
    validates :date_of_birth, presence: true
    validates :document_no, allow_blank: true, length: { is: 9 }
    validates :first_name, presence: true
    validates :id_number, presence: true, numericality: { only_integer: true }, length: { is: 11 }
    validates :last_name, presence: true
    validates :mobile_phone, telephone_number: { country: proc { |record| record.country }, types: [:mobile] }
    validates :serial, allow_blank: true, length: { is: 3 }
    validates :serial_no, allow_blank: true, numericality: { only_integer: true }
    validates_with ActivationServiceValidator
    validate :must_not_be_activated
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

    def prospective?
      ProspectiveStudent.not_archived.registered.exists?(id_number: id_number) ||
        ProspectiveEmployee.not_archived.exists?(id_number: id_number)
    end

    def active
      return unless valid?

      process
    rescue StandardError => e
      Rails.logger.error e.message
      errors.add(:base, I18n.t('.account.activations.system_error'))
      false
    end

    private

    def set_prospective_and_user
      @prospective = [*ProspectiveStudent.registered.where(id_number: id_number),
                      *ProspectiveEmployee.where(id_number: id_number)]
      @user = User.find_by(id_number: id_number)
    end

    def process
      set_prospective_and_user

      ActiveRecord::Base.transaction do
        prospective.map { |p| p.update(archived: true) }
        user.update(activated: true, activated_at: Time.zone.now)
      end
    end

    def must_not_be_activated
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
