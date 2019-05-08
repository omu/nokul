# frozen_string_literal: true

module Patron
  module Scope
    module Model
      extend ActiveSupport::Concern

      class_methods do
        def scope_for(user, **options)
          scope_klass.new(user, current_scope: current_scope).scope(options)
        end

        private

        def scope_klass
          @_scope_klass ||= "#{name}Scope".safe_constantize
        end
      end
    end
  end
end
