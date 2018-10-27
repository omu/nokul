# frozen_string_literal: true

module Simple
  class Container < Module
    def initialize(properties)
      data_class = Struct.new(*properties, keyword_init: true)

      readers = properties
      writers = properties.map { |property| "#{property}=" }

      delegate(*readers, *writers, :to_h, to: :@data)

      define_method :initialize do |**args|
        @data = data_class.new(**args)
        after_initialize
      end

      define_method(:after_initialize) {}
    end

    private_class_method :new

    def self.of(properties)
      new(properties)
    end
  end
end
