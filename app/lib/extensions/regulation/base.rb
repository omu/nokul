# frozen_string_literal: true

module Extensions
  module Regulation
    class Base
      module Configuration
        def display_name
          I18n.t(i18n_key)
        end

        def i18n_key(key = nil)
          @i18n_key ||= key || "regulations.#{version}.#{identifier}"
        end

        def version
          @_version ||= name.split('::')[0].downcase
        end

        def identifier(name = nil)
          @_identifier ||= name
        end

        def number(number = nil)
          @_number ||= number
        end

        def effective_date(datetime = nil)
          @_effectived_date ||= Date.parse(datetime) if datetime.present?
        end

        def repealed_at(datetime = nil)
          @_repealed_at ||= Datetime.parse(datetime) if datetime.present?
        end

        def register(identifier, metadata: {})
          clauses[identifier] = Metadata.new(metadata)
        end

        def valid!
          %i[
            identifier
            number
            effective_date
          ].each do |property|
            next if public_send(property).present?

            raise ArgumentError, "#{property} property should not be empty"
          end
        end
      end

      extend Configuration

      class << self
        def clauses
          @_clauses ||= {}
        end

        delegate :fetch, to: :clauses

        def call(identifier, *params)
          clause = fetch(identifier) { raise "clause not found for #{identifier}" }

          clause.klass.call(*params, store_key: clause.store)
        end
      end
    end
  end
end
