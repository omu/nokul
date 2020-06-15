# frozen_string_literal: true

module Extensions
  module Regulation
    class Base
      module Configuration
        AVAILABLE_SCOPES = %i[
          education
          assessment_and_evaluation
        ].freeze

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

        def scope(key = nil)
          @_scope ||= begin
            unless AVAILABLE_SCOPES.include?(key.to_sym)
              raise(ArgumentError, "Scope value must be one of #{AVAILABLE_SCOPES.to_sentence}")
            end

            key.to_sym
          end
        end

        def effective_date(datetime = nil)
          @_effectived_date ||= (Date.parse(datetime) if datetime.present?)
        end

        def repealed_at(datetime = nil)
          @_repealed_at ||= (Date.parse(datetime) if datetime.present?)
        end

        def register(identifier, metadata: {})
          clauses[identifier] = Metadata.new(metadata)
        end

        def active?(date = nil)
          date ||= Date.current

          return effective_date <= date if repealed_at.nil?

          effective_date <= date && repealed_at >= date
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

        def call(identifier, *params)
          clause = fetch(identifier)

          clause.klass.call(*params, executer: self)
        end

        def fetch(identifier)
          clauses.fetch(identifier) { raise "Not found #{identifier} clause for #{self.identifier} regulation" }
        end

        def included?(identifier)
          clauses.key? identifier
        end

        alias registered? included?
        alias [] fetch
      end
    end
  end
end
