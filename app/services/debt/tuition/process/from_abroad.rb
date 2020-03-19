# frozen_string_literal: true

require_relative '../tuition_handler'
require_relative '../operation/scholarship'

module Debt
  module Tuition
    module Process
      class FromAbroad < TuitionHandler
        def self.chain
          Operation::Scholarship.new
        end
      end
    end
  end
end
