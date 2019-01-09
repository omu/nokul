# frozen_string_literal: true

# Concern multiple units at any form

require 'yaml'

require_relative 'tree'

module Nokul
  module Tenant
    module Units
      module Concerns
        module Many
          extend ActiveSupport::Concern

          CONFIG_FILE = 'db/units/config.yml'

          class_methods do
            def load_source
              read_from_yaml_file Tenant.root.join collection.source
            end

            def store_source(units, **options)
              write_to_yaml_file Tenant.root.join(collection.source), units, **options
            end

            def config
              @config ||= (YAML.load_file(Tenant.root.join(CONFIG_FILE)) || {}).to_deep_ostruct
            end
          end

          def store(**options)
            self.class.store_source self, **options
          end

          def headline
            warn "====> #{collection.label}"
            warn ''
          end

          def as_canonical_yaml_string
            canonically_ordered.map(&:to_h).map(&:stringify_keys).to_yaml_pretty
          end

          include Tree
        end
      end
    end
  end
end
