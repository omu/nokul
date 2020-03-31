# frozen_string_literal: true

require_relative '../operation/scholarship'
require_relative '../operation/disability'
require_relative '../operation/no_discount'

module Debt
  module Tuition
    module Process
      class FromAbroad
        def self.chain
          Operation::Scholarship.new(Operation::Disability.new(Operation::NoDiscount.new))
        end
      end
    end
  end
end
