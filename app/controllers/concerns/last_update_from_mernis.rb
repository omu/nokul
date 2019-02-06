# frozen_string_literal: true

module LastUpdateFromMernis
  extend ActiveSupport::Concern

  def elapsed_time(resource)
    elapsed_time = (Time.zone.now - resource.updated_at) / 1.day
    return unless elapsed_time.blank? || elapsed_time < 7

    namespace, controller = request.controller_class.to_s.split('::')
    controller, _ = controller.split('Controller')

    if namespace.eql?('Account')
      redirect_to([controller.downcase], alert: t('.wait'))
    elsif namespace.eql?('UserManagement')
      redirect_to([namespace.tableize.singularize, @user, controller.downcase], alert: t('.wait'))
    end
  end
end
