# frozen_string_literal: true

module Debt
  module Tuition
    module Process
      class Daytime < Base
        def chain
          if exceeded? || other_studentship? || preparatory_repetition?
            Operation::Disability.new(Operation::NoDiscount.new)
          else
            Operation::Free.new
          end
        end
      end
    end
  end
end
