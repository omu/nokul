# frozen_string_literal: true

require_relative 'units/concerns'
require_relative 'units/src'
require_relative 'units/raw'
require_relative 'units/coder'

module Nokul
  module Tenant
    module Units
      RESOURCE = {
        'raw/yok' => Raw::YOKMany,
        'raw/det' => Raw::DETMany,

        'src/yok' => Src::YOKMany,
        'src/det' => Src::DETMany,
        'src/uni' => Src::UNIMany,
        'src/all' => Src::ALLMany
      }.freeze

      def self.resource?(resource)
        RESOURCE.key? resource
      end

      def self.method_missing(method, resource, *args)
        if (klass = RESOURCE[resource.to_s])
          return klass.send(method, *args) if klass.respond_to? method
          return klass.load_source.send(method, *args) if klass.method_defined? method
        end

        super
      end

      def self.respond_to_missing?(method, include_private: false)
        super
      end
    end
  end
end
