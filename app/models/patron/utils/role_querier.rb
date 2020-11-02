# frozen_string_literal: true

module Patron
  module Utils
    class RoleQuerier < SimpleDelegator
      def admin?
        any_roles? :admin
      end

      def institution_manager?
        positions&.active&.exists?(
          administrative_function_id: AdministrativeFunction.where(
            name: ['Rektör', 'Rektör Yardımcısı']
          )
        )
      end
    end
  end
end
