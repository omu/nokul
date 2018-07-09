# frozen_string_literal: true

module ReferenceResource
  extend ActiveSupport::Concern
  include Pagy::Backend

  # rubocop:disable Metrics/BlockLength
  # rubocop:disable Rails/LexicallyScopedActionFilter
  included do
    before_action :set_variables
    before_action :set_resource, only: %i[edit update destroy]

    def index
      @pagy, value = pagy(@model_name.all)
      instance_variable_set("@#{@controller_name}", value)
    end

    def new
      instance_variable_set(@singular_variable.to_sym, @model_name.new)
    end

    def create
      instance_variable_set(@singular_variable.to_sym, @model_name.new(secure_params))
      instance_variable_get(@singular_variable).save ? redirect_with('success') : render(:new)
    end

    def update
      if instance_variable_get(@singular_variable).update(secure_params)
        flash[:notice] = t('.success')
        redirect_to action: :index
      else
        render(:edit)
      end
    end

    def destroy
      instance_variable_get(@singular_variable).destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def set_variables
      @controller_name = params[:controller].split('/').last
      @singular_variable = "@#{@controller_name.singularize}"
      @model_name = @controller_name.classify.constantize
    end

    def set_resource
      instance_variable_set(@singular_variable.to_sym, @model_name.find(params[:id]))
    end

    def redirect_with(message)
      redirect_to(send("#{@controller_name}_path"), notice: t(".#{message}"))
    end
  end
  # rubocop:enable Metrics/BlockLength
  # rubocop:enable Rails/LexicallyScopedActionFilter
end
