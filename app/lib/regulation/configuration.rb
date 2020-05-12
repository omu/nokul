# frozen_string_literal: true

module Regulation
  module Configuration
    def register(identifier, **options)
      articles[identifier] = options
    end
  end
end
