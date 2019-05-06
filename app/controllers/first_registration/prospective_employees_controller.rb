# frozen_string_literal: true

module FirstRegistration
  class ProspectiveEmployeesController < ApplicationController
    include SearchableModule

    before_action :set_prospective_employee, only: %i[edit update destroy]

    def index
      prospective_employees = ProspectiveEmployee.not_archived.includes(:unit, :title)
                                                 .dynamic_search(search_params(ProspectiveEmployee))
      @pagy, @prospective_employees = pagy(prospective_employees)
    end

    def new
      @prospective_employee = ProspectiveEmployee.new
    end

    def create
      @prospective_employee = ProspectiveEmployee.new(prospective_employee_params)
      prospective = FirstRegistration::ProspectiveService.new(@prospective_employee)

      if prospective.register
        @prospective_employee.save ? redirect_to(:prospective_employees, notice: t('.success')) : render(:new)
      else
        render(:new)
      end
    end

    def edit; end

    def update
      if @prospective_employee.update(prospective_employee_params)
        redirect_to(:prospective_employees, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      if @prospective_employee.destroy
        redirect_to(:prospective_employees, notice: t('.success'))
      else
        redirect_to(:prospective_employees, alert: t('.warning'))
      end
    end

    private

    def set_prospective_employee
      @prospective_employee = ProspectiveEmployee.find(params[:id])
    end

    # rubocop:disable Metrics/MethodLength
    def prospective_employee_params
      params.require(:prospective_employee).permit(
        :date_of_birth,
        :email,
        :first_name,
        :gender,
        :id_number,
        :last_name,
        :mobile_phone,
        :staff_number,
        :title_id,
        :unit_id
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
