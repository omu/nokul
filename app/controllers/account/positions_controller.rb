# frozen_string_literal: true

module Account
  class PositionsController < ApplicationController
    before_action :set_user
    before_action :set_employee
    before_action :set_duty
    before_action :set_position, only: %i[edit update destroy]

    def new
      @position = @duty.positions.new
    end

    def create
      @position = @duty.positions.new(position_params)
      @position.save ? redirect_to([@user, @employee, @duty], notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @position.update(position_params) ? redirect_to([@user, @employee, @duty], notice: t('.success')) : render(:edit)
    end

    def destroy
      @position.destroy ? redirect_to([@user, @employee, @duty], notice: t('.success')) : redirect_with('warning')
    end

    private

    def set_user
      @user = User.find(params[:user_id])
      not_found unless @user
    end

    def set_employee
      @employee = @user.employees.friendly.find(params[:employee_id])
      not_found unless @employee
    end

    def set_duty
      @duty = @user.duties.find(params[:duty_id])
      not_found unless @duty
    end

    def set_position
      @position = @user.positions.find(params[:id])
      not_found unless @position
    end

    def position_params
      params.require(:position).permit(:administrative_function_id)
    end
  end
end
