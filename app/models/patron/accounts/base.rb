# frozen_string_literal: true

module Patron
  module Accounts
    class Base
      attr_reader :id, :user_id
      def initialize(id, user_id)
        @id      = id.to_i
        @user_id = user_id
      end

      def user
        @user ||= User.find(user_id)
      end

      def object
        raise NotImplementedError
      end

      def label
        raise NotImplementedError
      end

      def type
        raise NotImplementedError
      end

      def verify?
        raise NotImplementedError
      end

      def root_path
        :root
      end

      def active_for?(account)
        account&.identifier == identifier
      end

      def identifier
        {
          type: type,
          id:   id
        }
      end
    end
  end
end
