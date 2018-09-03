# frozen_string_literal: true

Vagrant.configure('2') do |config|
  config.vm.define 'dev', primary: true do |dev|
    dev.vm.box = 'omu/debian-stable-server'

    dev.vm.network 'forwarded_port', guest: 3000, host: 3000

    dev.vm.provider :lxc do |lxc|
      lxc.customize 'cgroup.memory.limit_in_bytes', '2048M'
    end

    dev.vm.provision 'shell', inline: <<~SHELL
      systemctl enable --now postgresql
      systemctl enable --now redis-server

      gem install bundler foreman

      cd /vagrant

      sudo -u postgres psql <<-EOF
        CREATE USER nokul WITH ENCRYPTED PASSWORD 'nokul';
        ALTER ROLE nokul LOGIN CREATEDB SUPERUSER;
      EOF

      sudo -u op sh -xs <<-EOF
        bundle install -j4 --deployment
        yarn install

        bin/rails db:create
        bin/rails db:migrate
        bin/rails db:seed
      EOF

      foreman export -p3000 --app nokul --user op systemd /etc/systemd/system/
      systemctl enable --now nokul.target
    SHELL
  end

  config.vm.define 'paas', autostart: false do |paas|
    paas.vm.box = 'omu/debian-stable-paas'
  end
end
