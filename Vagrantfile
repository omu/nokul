# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'omu/debian-stable-server'

  config.vm.network 'forwarded_port', guest: 3000, host: 3000

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '2048'
  end

  config.vm.provider :lxc do |lxc|
    lxc.customize 'cgroup.memory.limit_in_bytes', '2048M'
  end

  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    sudo systemctl enable postgresql
    sudo systemctl start postgresql
    sudo systemctl enable redis-server
    sudo systemctl start redis-server

    export RDS_USERNAME=nokul
    export RDS_PASSWORD=nokul

    sudo -u postgres psql <<<"CREATE USER $RDS_USERNAME WITH ENCRYPTED PASSWORD '$RDS_PASSWORD';"
    sudo -u postgres psql <<<"ALTER ROLE $RDS_USERNAME LOGIN CREATEDB;"

    sudo gem install bundler foreman

    cd /vagrant

    bundle install --deployment
    yarn install

    echo "RDS_USERNAME=$RDS_USERNAME" >.env
    echo "RDS_PASSWORD=$RDS_PASSWORD" >>.env
    echo "RDS_HOSTNAME=localhost" >>.env

    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake db:seed

    sudo foreman export -p3000 --app nokul --user op systemd /etc/systemd/system/
    sudo systemctl enable nokul.target
    sudo systemctl start nokul.target
  SHELL
end
