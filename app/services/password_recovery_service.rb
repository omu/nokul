# frozen_string_literal: true

class PasswordRecoveryService
  include ActiveModel::Validations

  attr_accessor :id_number,
                :password,
                :password_confirmation,
                :token,
                :mobile_phone,
                :country,
                :verification_code

  validates :id_number, presence: true, numericality: { only_integer: true }, length: { is: 11 }
  validates :mobile_phone, presence:         true,
                           telephone_number: { country: proc { |record| record.country }, types: [:mobile] }
  validate :check_informations

  def initialize(attributes = {})
    attributes.each do |name, value|
      public_send("#{name}=", value)
    end
    @mobile_phone = TelephoneNumber.parse(mobile_phone).e164_number
    @verification = VerificationService.new(mobile_phone: user.mobile_phone, code: verification_code) if user
  end

  def user
    User.find_by(id_number: id_number) || find_signed_id
  end

  def signed_id
    user&.signed_id expires_in: 15.minutes, purpose: :password_reset
  end

  def find_signed_id
    User.find_signed token, purpose: :password_reset
  end

  def update_password
    return false unless (user = find_signed_id)

    user.password = password
    user.password_confirmation = password_confirmation
    user.valid?

    return false unless errors.merge!(user.errors).empty?

    return false unless check_verification_code

    user.update(password: password, password_confirmation: password_confirmation)
  end

  def send_verification_code
    return true if @verification.send_code

    return false unless errors.merge!(@verification.errors).empty?

    errors.add(:base, I18n.t('.verification.code_can_not_be_send'))
    false
  end

  def check_verification_code
    return true if @verification.verify

    errors.add(:base, I18n.t('.verification.failed'))
    false
  end

  private

  def check_informations
    return if errors.any?

    return if user && (user.mobile_phone == mobile_phone)

    errors.add(:base, I18n.t('.account.password_recovery.no_matching_user'))
  end
end
