# frozen_string_literal: true

module ReferenceResource
  def self.included(base)
    base.class_eval do
      include YoksisResource

      def redirect_with(message)
        redirect_to(send("admin_#{controller_name}_path"), notice: t(".#{message}"))
      end
    end
  end
end
