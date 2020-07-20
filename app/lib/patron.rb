# frozen_string_literal: true

require_relative 'patron/roleable'
require_relative 'patron/scopable'
require_relative 'patron/utils/i18n'
require_relative 'patron/scope'
require_relative 'patron/permission_builder'
require_relative 'patron/role_builder'
require_relative 'patron/sudo'
require_relative 'patron/sudoable'

module Patron
  class Error < StandardError; end

  mattr_accessor :sudo_timeout, default: 15.minutes
  mattr_accessor :sudo_disable, default: false

  module_function

  def scope_names
    return scope_names_through_descendants if Rails.env.production?

    [*scope_names_through_files, *scope_names_through_descendants].uniq
  end

  def scope_names_through_descendants
    Patron::Scope::Base.descendants.map(&:to_s)
  end

  def scope_names_through_files
    Dir.glob(Rails.root.join('app/scopes/*.rb'))
       .map { |f| File.basename(f, '.rb').classify }
  end
end
