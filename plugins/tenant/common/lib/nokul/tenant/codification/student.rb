# frozen_string_literal: true

module Nokul
  module Tenant
    module Codification
      module Student
        mattr_accessor :const, default: ActiveSupport::InheritableOptions.new(gross_length: 8,
                                                                              year_length:  2)

        module_function

        def start_of_active_academic_year
          Date.current.strftime '%y' # TODO: placeholder
        end

        def short_number_generator(unit_code:, year: nil, starting:)
          unit_code  = Sanitized.unit_code(unit_code)
          year       = Sanitized.year(year)
          starting   = Sanitized.starting(starting, *(prefix = [unit_code, year]))
          net_length = Sanitized.net_length(*prefix)

          Support::Codification.sequential_numeric_codes starting, prefix: prefix, net_length: net_length, base: 10
        end

        def long_number_generator(unit_code:, starting:)
          unit_code  = Sanitized.unit_code(unit_code)
          starting   = Sanitized.starting(starting, *(prefix = [unit_code]))
          net_length = Sanitized.net_length(*prefix)

          Support::Codification.sequential_numeric_codes starting, prefix: prefix, net_length: net_length, base: 10
        end

        module Sanitized
          module_function

          def unit_code(unit_code)
            unit_code.length == Unit.const.gross_length ||
              raise(ArgumentError, "Unit code length must be #{Unit.const.gross_length}: #{unit_code}")
            unit_code
          end

          def year(year)
            year ||= start_of_active_academic_year
            year.length == Student.const.year_length ||
              raise(ArgumentError, "Academic year length must be #{Student.const.year_length}: #{year}")
            year
          end

          def net_length(*prefix)
            Student.const.gross_length - prefix.map(&:length).sum
          end

          def starting(starting, *prefix)
            net_length = net_length(*prefix)
            starting = 1.to_string(net_length, 10) if starting.blank? || starting.match?(/^0+$/)
            return starting if starting.length == net_length

            raise ArgumentError, "Starting sequence length must be #{net_length}: #{starting}"
          end
        end

        private_constant :Sanitized
      end
    end
  end
end
