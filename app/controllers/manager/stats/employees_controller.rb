# frozen_string_literal: true

module Manager
  module Stats
    class EmployeesController < ApplicationController
      layout false
      before_action do
        authorize(current_user, policy_class: Manager::Stats::EmployeePolicy)
      end

      def index; end

      def academic
        @series = Employee.active.academic.group('titles.name').count
      end
    end
  end
end
