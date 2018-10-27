# frozen_string_literal: true

module Tenant
  module_function

  def active
    ENV['RAILS_TENANT'] || 'omu'
  end

  def root
    Pathname.new Rails.root.join('tenant')
  end

  def path(relative_path)
    root.join(active, relative_path).to_s
  end

  def config_file
    File.join(Path.config, 'config.yml')
  end

  def configuration
    YAML.load_file(config_file).fetch(Rails.env, {}).to_deep_ostruct
  end

  def load_rules
    [*Path.common_rules, *rules].each do |dir|
      Dir[File.join(dir, '**', '*.rb')].each { |rule| require rule }
    end
  end

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
end
