# frozen_string_literal: true

module UserManagement
  class DutiesController < ApplicationController
    before_action :set_user
    before_action :set_duty, only: %i[edit update destroy]
    before_action :authorized?

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
      if @duty.destroy
        redirect_to(@user, notice: t('.success'))
      else
        redirect_to(users_path(@user), alert: t('.warning'))
      end
    end

    private

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def set_duty
      @duty = @user.duties.find(params[:id])
    end

    def authorized?
      authorize([:user_management, @duty || Duty])
    end

    def duty_params
      params.require(:duty).permit(:temporary, :start_date, :end_date, :unit_id, :employee_id, :article)
    end
  end
end
