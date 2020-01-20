# frozen_string_literal: true

module Nokul
  module SSO
    module_function

    def disabled?
      !enable?
    end

    def enable?
      ActiveRecord::Type::Boolean.new.cast(
        ENV.fetch('NOKUL_SSO_ENABLE', false)
      )
    end
  end
end
