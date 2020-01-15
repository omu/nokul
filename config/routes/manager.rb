# frozen_string_literal: true

namespace :manager do
  get '/', to: 'dashboard#index'

  namespace :charts do
    get :cities
    get :double_major_and_minor
    get :genders
    get :genders_and_degrees
    get :non_graduates
  end
end
