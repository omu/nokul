# frozen_string_literal: true

module Manager
  module Stats
    class EmployeesController < ApplicationController
      layout false

      def index; end

      def academic
        @series = Employee.active.academic.group('titles.name').count
      end
    end
  end
end
