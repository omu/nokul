# frozen_string_literal: true

module Patron
  module Scope
    class Base
      extend DSL
      extend View::Form

      class << self
        def model
          to_s.delete_suffix('Scope').safe_constantize
        end

        def preview_for_records(*records)
          query = Query::Builder.build_for_preview(new(nil), records)

          query.present? ? model.where(query) : model.none
        end
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
