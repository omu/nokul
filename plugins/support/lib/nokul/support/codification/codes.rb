# frozen_string_literal: true

require_relative 'codes/sequential_numeric_codes'
require_relative 'codes/alternative_user_names'
require_relative 'codes/suffixed_user_names'

module Nokul
  module Support
    module Codification
      # Create high level API for convenience

      mattr_accessor :codifications, default: [
        SequentialNumericCodes, # sequential_numeric_codes(source, **options)
        SuffixedUserNames,      # suffixed_user_names(source, **options)
        AlternativeUserNames    # alternative_user_names(source, **options)
      ]

      module_function

      codifications.each do |codification|
        method = codification.to_s.demodulize.underscore.downcase
        define_method method do |*args, **options, &block|
          codification::Coder.new(codification::Code.new(*args, **options), **options, &block)
        end
      end
    end
  end
end
