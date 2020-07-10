# frozen_string_literal: true

module ReferenceResource
  def self.included(base)
    base.class_eval do
      include YoksisResource

      def redirect_with(message)
        redirect_to(public_send("reference_#{controller_name}_path"), notice: t(".#{message}"))
      end

      protected

      def authorized?
        authorize([:reference, instance_variable_get(@singular_variable.to_sym) || @model_name])
      end
    end
  end
end
