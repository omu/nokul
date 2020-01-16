# frozen_string_literal: true

namespace :manager do
  get '/', to: 'dashboard#index'

  scope module: :statistics do
    get 'articles', to: 'articles#index'
    get 'employees', to: 'employees#index'
    namespace :students do
      get '/', action: :index
      get :cities
      get :double_major_and_minor
      get :genders
      get :genders_and_degrees
      get :non_graduates
    end
  end
end
