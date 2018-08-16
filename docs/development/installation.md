# Installation

## Prerequisites
- [NodeJS (>=10.x)](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
- [Yarn](https://yarnpkg.com/lang/en/docs/install/#debian-stable)
- [Redis](https://packages.debian.org/search?keywords=redis)
- [libvips](https://github.com/jcupitt/libvips/wiki/Build-for-Ubuntu)


## Installation

- Database configuration file reads username, password and host settings from environment variables. Make sure to define these environment variables before setting up the project. Add environment variables to your .bashrc, .zshrc, .bash_profile etc.:

```
export RDS_USERNAME=PostgreSQL username
export RDS_PASSWORD=PostgreSQL password
export RDS_HOSTNAME=localhost
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
