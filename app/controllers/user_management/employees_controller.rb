# frozen_string_literal: true

module UserManagement
  class EmployeesController < ApplicationController
    include SearchableModule

    before_action :set_user, except: %i[index]
    before_action :set_employee, only: %i[edit update destroy]
    before_action :authorized?

    def index
      @employees = pagy_by_search(Employee.active).includes(:user)
    end

    def new
      @employee = @user.employees.new
    end

    def create
      @employee = @user.employees.new(employee_params)
      @employee.save ? redirect_to(@user, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @employee.update(employee_params) ? redirect_to(@user, notice: t('.success')) : render(:edit)
    end

    def destroy
      if @employee.destroy
        redirect_to(@user, notice: t('.success'))
      else
        redirect_to(users_path(@user), alert: t('.warning'))
      end
    end

    private

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def set_employee
      @employee = @user.employees.find(params[:id])
    end

    def authorized?
      authorize([:user_management, @employee || Employee])
    end

    def employee_params
      params.require(:employee).permit(:active, :title_id, :staff_number)
    end
  end
end
