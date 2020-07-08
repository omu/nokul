# frozen_string_literal: true

module Debt
  module Tuition
    module Process
      class Evening < Base
        def chain
          if exceeded? || other_studentship? || preparatory_repetition?
            Operation::Disability.new(Operation::NoDiscount.new)
          else
            Operation::Scholarship.new(Operation::Disability.new(Operation::NoDiscount.new))
          end
        end
      end
    end
  end
end
