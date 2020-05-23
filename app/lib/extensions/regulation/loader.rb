# frozen_string_literal: true

module Extensions
  module Regulation
    module Loader
      module_function

      def call
        return if Rails.env.production?

        Dir.glob(Rails.root.join('app/regulations/articles/**/*.rb'))
           .each { |file| load file }
      end
    end
  end
end
