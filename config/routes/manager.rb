# frozen_string_literal: true

namespace :manager do
  get :stats, to: 'dashboard#stats'

  scope module: :stats do
    get 'articles', to: 'articles#index'
    namespace :employees do
      get '/', action: :index
      get :academic
    end
    namespace :students do
      get '/', action: :index
      get :cities
      get :double_major_and_minor
      get :genders
      get :genders_and_degrees
      get :non_graduates
      get :units
    end
  end
end
