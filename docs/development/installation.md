# Installation

## Prerequisites
- [NodeJS (>=10.x)](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
- [Yarn](https://yarnpkg.com/lang/en/docs/install/#debian-stable)
- [Redis](https://packages.debian.org/search?keywords=redis)
- [libvips](https://github.com/jcupitt/libvips/wiki/Build-for-Ubuntu)

## Installation

- Create a separate PostgreSQL user for the development and test environments. As per our policy, PostgreSQL user name must be the same as the application name: `nokul`.

```bash
sudo -u postgres psql <<-EOF
        CREATE USER nokul WITH ENCRYPTED PASSWORD 'nokul';
        ALTER ROLE nokul LOGIN CREATEDB SUPERUSER;
EOF
```

In order to communicate with third parties, you also need to setup some credentials which are stored in `credentials.yml.enc`. For obtaining credentials you can either download a copy of `master.key` into config/ or you can define the key value as `RAILS_MASTER_KEY` environment variable. For adding new secrets run the command show, below after you obtain the key:

```ruby
bin/rails credentials:edit
```

- Install GEM dependencies:

```bash
bundle
```

- Install asset dependencies:

```bash
yarn install
```

- Create database, migrate tables and run the seed data:

```bash
rake db:create
rake db:migrate
rake db:seed
```

- If you are setting up again, when you already have previous databases:

```bash
rake db:reset
```

`reset` is equivalent of `rake db:drop & rake db:setup`.
