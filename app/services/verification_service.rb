# frozen_string_literal: true

class VerificationService
  attr_reader :mobile_phone, :code, :errors

  SENDING_TIMESPAN = 300 # redis'teki key 5 dakika geçerli olmalı
  ALLOWED_SMS_COUNT = 3 # yukarıda ayarlanan süre boyunca gönderilebilen sms sayısı

  def initialize(**args)
    @mobile_phone = TelephoneNumber.parse(args[:mobile_phone]).e164_number
    @code = args[:code]
    @verification = set_verification
    @errors = ActiveModel::Errors.new(self)
  end

  def verify
    REDIS.hset(key, { verified: 'true' }) if @verification[:code] == @code
  end

  def send_code
    return false unless can_be_sent?

    SMS.call(to: @mobile_phone, body: I18n.t('.verification.sms_code_message', code: @verification[:code]))
    increase_sent_count
    true
  end

  def can_be_sent?
    if REDIS.hget(key, 'sent_count').to_i >= ALLOWED_SMS_COUNT
      @errors.add(:base, I18n.t('.verification.too_many_requests'))
      false
    else
      true
    end
  end

  def increase_sent_count
    REDIS.hincrby(key, 'sent_count', 1)
    REDIS.expire(key, SENDING_TIMESPAN)
  end

  private

  def key
    "verification_#{@mobile_phone}"
  end

  def set_verification # rubocop:disable Metrics/MethodLength
    verification = REDIS.hgetall(key).deep_symbolize_keys

    if verification.empty?
      verification = { code: rand(100_000..999_999), verified: false, sent_count: 0 }
    elsif verification[:verified] == 'true' # son 5 dakika içinde doğrulama olmasına rağmen yeniden istek var
      verification = { code: rand(100_000..999_999), verified: false }
    elsif !@code # kod oluşturulmuş ancak doğrulama yapılmadan yeni bir istek varsa kodu yeniden üret
      verification = { code: rand(100_000..999_999) }
    else # bu aşamaya yalnızca kodu doğrulama amaçlı servisi çağırırken ulaşabilir
      return verification
    end

    REDIS.hset(key, verification)
    verification
  end
end
