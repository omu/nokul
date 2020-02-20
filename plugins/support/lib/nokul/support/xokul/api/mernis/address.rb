# frozen_string_literal: true

module Xokul
  module Mernis
    class Address < Endpoint
      configure do |config|
        config.synopsis         = "Get someone's address information from Mernis"
        config.namespace        = '/mernis/addresses'
        config.upstream_version = '1'
      end
    end
  end
end
