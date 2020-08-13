# frozen_string_literal: true

class VerificationService
  attr_reader :mobile_phone, :code, :errors

  SENDING_TIMESPAN = 300 # redis'teki key 5 dakika geçerli olmalı
  ALLOWED_SMS_COUNT = 3 # yukarıda ayarlanan süre boyunca gönderilebilen sms sayısı

  def initialize(**args)
    @mobile_phone = TelephoneNumber.parse(args[:mobile_phone]).e164_number
    @code = args[:code].to_i
    @verification = Verification.find_or_initialize_by(mobile_phone: @mobile_phone)
    prepare_verification
    @errors = ActiveModel::Errors.new(self)
  end

  def verify
    @verification.update(verified: true) if @verification.code == @code
  end

  def send_code
    return false unless @verification.valid?

    return false unless can_be_sent?

    SMS.call(to: @mobile_phone, body: I18n.t('.verify.sms_code_message', code: @verification.code))
    increase_sending_count
    true
  end

  # sms gönderimine limit uygulamak için redis kullanıldı.
  def can_be_sent? # rubocop:disable Metrics/MethodLength
    if (redis_count = REDIS.get(count).to_i)
      if redis_count > ALLOWED_SMS_COUNT
        @errors.add(:base, I18n.t('.verify.too_many_requests'))
        false
      else
        true
      end
    else
      REDIS.set(count, 0)
      REDIS.expire(count, SENDING_TIMESPAN)
      true
    end
  end

  def increase_sending_count
    REDIS.incr count
    REDIS.expire(count, SENDING_TIMESPAN)
  end

  private

  def prepare_verification
    if @verification.verified?
      @verification.verified = false
      @verification.code = rand(100_000..999_999)
    else
      @verification.code = rand(100_000..999_999) unless REDIS.get(count)
    end
    @verification.save
  end

  def count
    "sms_count_#{@mobile_phone}"
  end
end
