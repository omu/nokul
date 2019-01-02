# frozen_string_literal: true

Vagrant.configure('2') do |config|
  env = {
    'HOSTPATH': ENV['HOSTPATH']
  }

  config.vm.define 'dev', primary: true do |dev|
    dev.vm.box = 'omu/debian-stable-server'

    dev.vm.network 'forwarded_port', guest: 3000, host: 3000

    dev.vm.provider :lxc do |lxc|
      lxc.customize 'cgroup.memory.limit_in_bytes', '2048M'
    end

    dev.vm.provision 'shell', name: 'environment', env: env, path: 'lib/scripts/vagrant/depends.sh'
    dev.vm.provision 'shell', name: 'environment', env: env, path: 'lib/scripts/vagrant/environment.sh'
    dev.vm.provision 'shell', name: 'deploy',      env: env, path: 'lib/scripts/vagrant/deploy.sh'
  end

  config.vm.define 'paas', autostart: false do |paas|
    paas.vm.box = 'omu/debian-stable-paas'

    paas.trigger.after :provision do |trigger|
      Dir.chdir __dir__

      trigger.info = 'Provisioning paas...'
      trigger.run = { inline: 'bash lib/scripts/vagrant/paas.sh' }
    end
  end
end
