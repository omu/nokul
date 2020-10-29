# frozen_string_literal: true

module Account
  class ProfileController < ApplicationController
    include Pagy::Backend
    PAGY_ITEMS = 10

    before_action :set_user

    # before_action :purge_avatar, only: :update
    def index
      @education_informations = @user.education_informations.active.order(start_year: :desc)
      @academic_credentials   = @user.academic_credentials.active.order(start_year: :desc)
    end

    def edit; end

    def update
      if @user.update_without_password(profile_params)
        redirect_to :profile, notice: t('.success')
      else
        render(:edit)
      end
    end

    def articles
      @pagy, @articles = pagy(
        @user.articles.active.order(year: :desc),
        link_extra: 'data-remote="true"',
        items:      PAGY_ITEMS
      )
    end

    def books
      @pagy, @books = pagy(
        @user.books.active.order(year: :desc),
        link_extra: 'data-remote="true"',
        items:      PAGY_ITEMS
      )
    end

    def certifications
      @pagy, @certifications = pagy(
        @user.certifications.active,
        link_extra: 'data-remote="true"',
        items:      PAGY_ITEMS
      )
    end

    def papers
      @pagy, @papers = pagy(
        @user.papers.active,
        link_extra: 'data-remote="true"',
        items:      PAGY_ITEMS
      )
    end

    def projects
      @pagy, @projects = pagy(
        @user.projects.active.order(start_date: :desc),
        link_extra: 'data-remote="true"',
        items:      PAGY_ITEMS
      )
    end

    private

    # def purge_avatar
    #   current_user.avatar.purge
    # end

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def profile_params
      params.require(:user).permit(
        :avatar, :country, :fixed_phone, :extension_number, :website, :twitter, :linkedin, :skype, :orcid
      )
    end
  end
end
