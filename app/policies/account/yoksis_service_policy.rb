# frozen_string_literal: true

module Account
  class YoksisServicePolicy < ApplicationPolicy
    def fetch?
      user.employee? && user.current_employee&.academic?
    end
  end
end
