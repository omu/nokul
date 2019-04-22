# frozen_string_literal: true

module Patron
  module Scope
    class Base
      extend DSL
      extend View::Form

      def self.model
        to_s.delete_suffix('Scope').safe_constantize
      end

      attr_reader :user

      def initialize(user, current_scope: nil)
        @user          = user
        @current_scope = current_scope
      end

      def scope(bypass: nil)
        return model.all if bypass.nil? ? bypass? : bypass

        query = Query::Builder.call(self)

        @current_scope = query.present? ? model.where(query) : model.none
      end

      def bypass?
        false
      end

      protected

      def current_scope
        @current_scope || scope || model
      end

      def model
        @_model ||= self.class.model
      end
    end
  end
end
