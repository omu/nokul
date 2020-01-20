# frozen_string_literal: true

module Nokul
  module SSO
    module_function

    def disabled?
      !enabled?
    end

    def enabled?
      ActiveRecord::Type::Boolean.new.cast(
        ENV.fetch('NOKUL_SSO_ENABLE', false)
      )
    end
  end
end
