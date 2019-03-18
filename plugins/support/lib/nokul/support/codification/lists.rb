# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      module Lists
        class List < SimpleDelegator
          attr_reader :source

          def initialize(source = [], **options)
            source.must_be_any_of! Array

            @source = sanitize(source)

            __setobj__ generate(**options)
          end

          protected

          def sanitize(source)
            source
          end

          def generate(**)
            source
          end
        end
      end
    end
  end
end

require_relative 'lists/user_names'
