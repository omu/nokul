# frozen_string_literal: true

module Account
  class EmployeesController < ApplicationController
    before_action :set_user
    before_action :set_employee, only: %i[show edit update destroy]

    def show
      @positions = @employee.positions
    end

    def new
      @employee = @user.employees.new
    end

    def create
      @employee = @user.employees.new(employee_params)
      @employee.save ? redirect_to(user_employee_path(@user, @employee), notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @employee.update(employee_params) ? redirect_to([@user, @employee], notice: t('.success')) : render(:edit)
    end

    def destroy
      @employee.destroy ? redirect_to(@user, notice: t('.success')) : redirect_with('warning')
    end

    private

    def set_user
      @user = User.find(params[:user_id])
      not_found unless @user
    end

    def set_employee
      @employee = @user.employees.find(params[:id]) if @employee
    end

    def employee_params
      params.require(:employee).permit(:active, :title_id, :user_id)
    end
  end
end
