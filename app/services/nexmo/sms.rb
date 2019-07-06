# frozen_string_literal: true

require_relative 'error_handler'

module Nexmo
  class Sms
    include ErrorHandler

    # Some countries and operators do not support concatenation and unicode.
    # Enable multipart and unicode type thoughtfully!
    # Nexmo supports all the standard GSM characters + characters from the GSM extended table.
    # Test GSM-7 encoding: http://chadselph.github.io/smssplit/
    def initialize(to_number, message, country = 'tr', multipart = false, type = 'text')
      @to_number = to_number.to_s
      @message = type.eql?('text') ? message.asciified.squish : message
      @country = country
      @multipart = multipart
      @type = type

      process_message
    end

    private

    def process_message
      check_country
      check_destination_number
      check_multipart
      check_encoding
      send_message
    end

    def check_country
      @country = Country.find_by(alpha_2_code: @country.upcase)

      raise ActiveRecord::RecordNotFound, 'Country can not be found!' unless @country
    end

    def check_destination_number
      valid_number = TelephoneNumber.valid?(@to_number, @country.alpha_2_code.to_sym, [:mobile])

      raise InvalidPhoneNumberError unless valid_number

      parser = TelephoneNumber.parse(@to_number, @country.alpha_2_code.to_sym)
      @to_number = parser.country.country_code + parser.formatter.normalized_number
    end

    def check_multipart
      encoding = SmsTools::EncodingDetection.new(@message)

      raise ConcatenationError if @multipart.eql?(false) && encoding.concatenated?
      raise ConcatenationError if @multipart.eql?(false) && !@country.sms_concatenation
    end

    def check_encoding
      encoding = SmsTools::EncodingDetection.new(@message).encoding.to_s
      encoding = 'text' if encoding.eql?('gsm') || encoding.eql?('ascii')

      raise EncodingMismatchError unless encoding == @type
      raise UnicodeSupportError if encoding.eql?('unicode') && !@country.sms_unicode
    end

    def send_message
      response = NEXMO_CLIENT.sms.send(
        from: Tenant.credentials.dig(:nexmo, :from),
        to:   @to_number,
        type: @type,
        text: @message
      ).messages.first

      log_or_notify_admin(response)
    end
  end
end
