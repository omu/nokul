# frozen_string_literal: true

module UserManagement
  class PositionsController < ApplicationController
    before_action :set_user
    before_action :set_duty, only: %i[create update]
    before_action :set_position, only: %i[edit update destroy]

    def new
      @position = Position.new
    end

    def create
      @position = @duty.positions.new(position_params)
      @position.save ? redirect_to(@user, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @position.update(position_params) ? redirect_to(@user, notice: t('.success')) : render(:edit)
    end

    def destroy
      if @position.destroy
        redirect_to(@user, notice: t('.success'))
      else
        redirect_to(users_path(@user), alert: t('.warning'))
      end
    end

    private

    def set_user
      @user = User.friendly.find(params[:user_id])
      not_found unless @user
    end

    def set_duty
      @duty = @user.duties.find(position_params[:duty_id])
      not_found unless @duty
    end

    def set_position
      @position = @user.positions.find(params[:id])
      not_found unless @position
    end

    def position_params
      params.require(:position).permit(:duty_id, :administrative_function_id, :start_date, :end_date)
    end
  end
end
