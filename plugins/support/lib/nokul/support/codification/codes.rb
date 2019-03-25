# frozen_string_literal: true

require_relative 'codes/sequential_numeric_codes'
require_relative 'codes/random_numeric_codes'
require_relative 'codes/unsuffixed_user_names'
require_relative 'codes/suffixed_user_names'

module Nokul
  module Support
    module Codification
      # Create high level API for convenience

      mattr_accessor :codifications, default: [
        SequentialNumericCodes, # sequential_numeric_codes(source, **options)
        RandomNumericCodes,     # random_numeric_codes(source, **options)
        UnsuffixedUserNames,    # unsuffixed_user_names(source, **options)
        SuffixedUserNames       # suffixed_user_names(source, **options)
      ]

      module_function

      codifications.each do |codification|
        name            = codification.to_s.demodulize.underscore

        plural_method   = name.pluralize
        singular_method = name.singularize

        define_method plural_method do |*args, **options, &block|
          codification::Coder.new(codification::Code.new(*args, **options), **options, &block)
        end

        define_method singular_method do |*args, **options, &block|
          send(plural_method, *args, **options, &block).run
        end
      end
    end
  end
end
