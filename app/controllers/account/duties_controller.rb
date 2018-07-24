# frozen_string_literal: true

module Account
  class DutiesController < ApplicationController
    before_action :set_user
    before_action :set_employee
    before_action :set_duty, only: %i[show edit update destroy]

    def show
      @positions = @duty.positions
    end

    def new
      @duty = @user.duties.new
    end

    def create
      @duty = @employee.duties.new(duty_params)
      @duty.save ? redirect_to(@user, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @duty.update(duty_params) ? redirect_to([@user, @duty], notice: t('.success')) : render(:edit)
    end

    def destroy
      @duty.destroy ? redirect_to(@user, notice: t('.success')) : redirect_with('warning')
    end

    private

    def set_user
      @user = User.find(params[:user_id])
      not_found unless @user
    end

    def set_employee
      @employee = @user.employees.find(params[:employee_id])
      not_found unless @employee
    end

    def set_duty
      @duty = @user.duties.find(params[:id]) if @duty
    end

    def duty_params
      params.require(:duty).permit(:temporary, :start_date, :end_date, :employee_id, :unit_id)
    end
  end
end
