# frozen_string_literal: true

require_relative 'patron/roleable'
require_relative 'patron/scopable'
require_relative 'patron/utils/i18n.rb'
require_relative 'patron/scope'
require_relative 'patron/permission_builder'
require_relative 'patron/role_builder'

module Patron
  class Error < StandardError; end

  module_function

  def scope_names
    return Patron::Scope::Base.descendants.map(&:to_s) if Rails.env.production?

    scope_names =
      Dir.glob(Rails.root.join('app', 'scopes', '*.rb'))
         .map { |f| File.basename(f, '.rb').classify }

    [*scope_names, *Patron::Scope::Base.descendants.map(&:to_s)].uniq
  end
end
