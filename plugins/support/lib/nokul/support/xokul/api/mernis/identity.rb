# frozen_string_literal: true

module Xokul
  module Mernis
    class Identity < Endpoint
      configure do |config|
        config.synopsis         = "Get someone's identity information from Mernis"
        config.namespace        = '/mernis/identities/query'
        config.upstream_version = '1'
      end
    end
  end
end
