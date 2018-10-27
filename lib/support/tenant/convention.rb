# frozen_string_literal: true

require 'pathname'

module Tenant
  module_function

  module Path
    module_function

    %w[app config db test].each do |subdir|
      define_method(subdir) do |*paths|
        Tenant.root.join(Tenant.active, subdir, *paths).to_s
      end

      define_method("common_#{subdir}") do |*paths|
        Tenant.root.join('common', subdir, *paths).to_s
      end
    end
  end

  def active
    ENV['RAILS_TENANT'] || 'omu'
  end

  def config_file
    File.join(Path.config, 'config.yml')
  end

  def configuration
    YAML.load_file(config_file).fetch(Rails.env, {}).to_deep_ostruct
  end

  def root
    Pathname.new Rails.root.join('tenant')
  end

  def file(relative_path)
    root.join(active, relative_path).to_s
  end

  def rules
    File.join(Path.app, 'rules')
  end

  def common_rules
    File.join(Path.common_app, 'rules')
  end

  # def load_rules
  #   [*Path.common_rules, *rules].each do |dir|
  #     Dir[File.join(dir, '**', '*.rb')].each { |rule| require rule }
  #   end
  # end

  def init
    # load_rules
  end
end
