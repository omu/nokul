# frozen_string_literal: true

require 'set'

require_relative 'collection'

module Nokul
  module Support
    class UniqCollection < Collection
      def self.create(hashes = [])
        new Set.new canonicalize_hashes hashes
      end

      def __ensure_construction__
        return @delegate_sd_obj if @delegate_sd_obj.is_a? Set

        raise Error, "Construction argument must be a Set where found #{@delegate_sd_obj.class}"
      end
    end
  end
end
