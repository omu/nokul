# frozen_string_literal: true

namespace :reference do
  get '/', to: 'dashboard#index'
  resources :academic_terms,     except: :show
  resources :assessment_methods, except: :show
  resources :course_group_types, except: :show
  resources :course_types,       except: :show
  resources :document_types,     except: :show
  resources :evaluation_types,   except: :show
  resources :high_school_types,  except: :show
  resources :languages,          except: :show
  resources :scholarship_types,  except: :show
  resources :titles,             except: :show
end
