# frozen_string_literal: true

# See https://www.twilio.com/docs/lookup/api for options

module Twilio
  class Lookup
    def initialize(number, **options)
      @response = TWILIO_CLIENT.lookups.phone_numbers(number.to_s).fetch(options)
    end
  end
end
