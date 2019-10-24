module ServiceWorkers
  class WorkersController < ApplicationController
    protect_from_forgery except: :index
    skip_before_action :authenticate_user!
    
    def index
    end
  end
end
