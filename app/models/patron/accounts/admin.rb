# frozen_string_literal: true

module Patron
  module Accounts
    class Admin < Base
      def object
        user
      end

      def label
        "#{identity.first_name} #{identity.last_name}"
      end

      def type
        'admin'
      end

      def verify?
        object.present?
      end
    end
  end
end
