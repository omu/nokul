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
    attributes.each { |name, value| public_send("#{name}=", value) }
    @mobile_phone = TelephoneNumber.parse(user.mobile_phone).e164_number if user
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
    pass :base, I18n.t('.verification.code_can_not_be_send') do
      Actions::User::Verification::Send.call(@mobile_phone)
    end
  end

  def check_verification_code
    pass :base, I18n.t('.verification.failed') do
      Actions::User::Verification::Verify.call(@mobile_phone, verification_code)
    end
  end

  private

  def check_informations
    return if errors.any?

    return if user && (user.mobile_phone == mobile_phone)

    errors.add(:base, I18n.t('.account.password_recovery.no_matching_user'))
  end

  def pass(*args)
    return true if (result = yield).ok?

    errors.merge!(result.errors)
    errors.add(*args)
    false
  end
end
