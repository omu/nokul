# frozen_string_literal: true

module Nokul
  module Tenant
    module Codification
      module User
        mattr_accessor :const, default: ActiveSupport::InheritableOptions.new(random_suffix_length:    3,
                                                                              random_suffix_separator: '.')

        module_function

        def name_generate(first_name:, last_name:, memory:, **options)
          Support::Codification.suffixed_user_name [first_name, last_name],
                                                   **options,
                                                   memory:                  memory,
                                                   random_suffix_separator: const.random_suffix_separator,
                                                   random_suffix_length:    const.random_suffix_length
        end

        def name_suggest(first_name:, last_name:, memory:, **options)
          Support::Codification.unsuffixed_user_names([first_name, last_name],
                                                      **options,
                                                      memory: memory).available
        end
      end
    end
  end
end
