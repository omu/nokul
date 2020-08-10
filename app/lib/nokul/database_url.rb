# frozen_string_literal: true

module Nokul
  module DatabaseUrl
    module_function

    def application
      Nokul::Name.application
    end

    def url
      host = ENV.fetch('DB_HOST', 'localhost')
      "postgresql://#{application}:#{application}@#{host}/#{application}"
    end

    def development
      "#{url}_development"
    end

    def production
      "#{url}_production"
    end

    def test
      "#{url}_test"
    end
  end
end
