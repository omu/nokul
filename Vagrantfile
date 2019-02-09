# frozen_string_literal: true

Vagrant.configure('2') do |config| # rubocop:disable Metrics/BlockLength
  env = {}

  if ENV['LOCAL_CACHE_DIR']
    FileUtils.mkdir_p ENV['LOCAL_CACHE_DIR'] unless Dir.exist?(ENV['LOCAL_CACHE_DIR'])
    app_cache_dir = '/var/cache/app'

    config.vm.synced_folder ENV['LOCAL_CACHE_DIR'], app_cache_dir

    env['LOCAL_CACHE_DIR'] = app_cache_dir
  end

  config.vm.define 'dev', primary: true do |dev|
    dev.vm.box = 'omu/debian-stable-server'

    dev.vm.network 'forwarded_port', guest: 3000, host: 3000

    dev.vm.provider :lxc do |lxc|
      lxc.customize 'cgroup.memory.limit_in_bytes', '2048M'
    end

    dev.vm.provision 'shell', name: 'environment', env: env, path: 'lib/scripts/environment.sh'
    dev.vm.provision 'shell', name: 'deploy',      env: env, path: 'lib/scripts/deploy.sh'

    dev.trigger.after [:up, :reload] do |trigger|
      trigger.info = 'Starting app...'
      trigger.run_remote = { inline: 'app start' }
    end

    dev.trigger.before :halt do |trigger|
      trigger.info = 'Stopping app...'
      trigger.run_remote = { inline: 'app stop' }
    end
  end

  config.vm.define 'paas', autostart: false do |paas|
    paas.vm.box = 'omu/debian-stable-paas'

    paas.trigger.after :provision do |trigger|
      Dir.chdir __dir__

      trigger.info = 'Provisioning paas...'
      trigger.run = { inline: 'bash lib/scripts/paas.sh' }
    end
  end
end
