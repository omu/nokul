# frozen_string_literal: true

module Regulation
  module Configuration
    def register(identifier, metadata: {})
      articles[identifier] = Metadata.new(metadata)
    end
  end
end
