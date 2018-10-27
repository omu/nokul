# frozen_string_literal: true

module Tenant
  module_function

  def active
    ENV['RAILS_TENANT'] || 'omu'
  end

  def root
    Rails.root.join('tenant') # Pathname object
  end

  def path(*paths)
    root.join(active, *paths).to_s
  end

  def config_file
    Path.config.join('config.yml').to_s
  end

  def configuration
    YAML.load_file(config_file).fetch(Rails.env, {}).to_deep_ostruct
  end

  def load_rules(*paths)
    [*Path.common_app.join('rules'), *Path.app.join('rules')].each do |path|
      next unless Dir.exist? path

      Dir[path.join(*paths, '**', '*.rb')].each { |rule| require rule }
    end
  end

  module Path
    module_function

    # All methods should return Pathname objects

    def common(*paths)
      Tenant.root.join('common', *paths)
    end

    %w[app config db test].each do |subdir|
      define_method(subdir) do |*paths|
        Tenant.root.join(Tenant.active, subdir, *paths)
      end

      define_method("common_#{subdir}") do |*paths|
        common.join(subdir, *paths)
      end
    end
  end
end
