# frozen_string_literal: true

module Account
  class DutiesController < ApplicationController
    before_action :set_user
    before_action :set_duty, only: %i[edit update destroy]

    def new
      @duty = @user.duties.new
    end

    def create
      @duty = @user.duties.new(duty_params)
      @duty.save ? redirect_to(@user, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @duty.update(duty_params) ? redirect_to(@user, notice: t('.success')) : render(:edit)
    end

    def destroy
      @duty.destroy ? redirect_to(@user, notice: t('.success')) : redirect_with('warning')
    end

    private

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def set_duty
      @duty = @user.duties.find(params[:id])
    end

    def duty_params
      params.require(:duty).permit(:temporary, :start_date, :end_date, :unit_id, :employee_id)
    end
  end
end
