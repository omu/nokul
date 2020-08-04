# frozen_string_literal: true

class PasswordRecoveryService
  include ActiveModel::Validations

  attr_accessor :id_number,
                :new_password,
                :new_password_confirmation,
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

    user.password = new_password
    user.password_confirmation = new_password_confirmation
    user.valid?

    return false unless errors.merge!(user.errors).empty?

    return false unless check_verification_code

    user.update(password: new_password, password_confirmation: new_password_confirmation)
  end

  def send_verification_code
    return true if Twilio::Verify.send_phone_verification_code(user.mobile_phone).ok?

    errors.add(:base, I18n.t('.account.password_recovery.not_send_verify_code'))
    false
  end

  def check_verification_code
    response = Twilio::Verify.check_verification_code(user.mobile_phone, verification_code)

    return true if response.ok?

    errors.add(:base, I18n.t("twilio.errors.#{response.error_code}")) && nil
  end

  private

  def check_informations
    return if errors.any?

    return if user && (user.mobile_phone == mobile_phone)

    errors.add(:base, I18n.t('.account.password_recovery.no_matching_user'))
  end
end
