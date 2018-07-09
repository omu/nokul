# Nokul

[![Product](https://assets.omu.sh/badge/product.svg)](https://omu.sh "BAUM Product") [![Maintainability](https://api.codeclimate.com/v1/badges/32e076b5cbd4ee545f48/maintainability)](https://codeclimate.com/github/omu/nokul/maintainability) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/2c7333e690454bbd99811c8860f08d2b)](https://www.codacy.com/app/msdundar/nokul?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=omu/nokul&amp;utm_campaign=Badge_Grade) [![CircleCI](https://circleci.com/gh/omu/nokul/tree/master.svg?style=svg&circle-token=a25e63abc0e1e6c074750d9b2ce5396e3e279d82)](https://circleci.com/gh/omu/nokul/tree/master) [![Codacy Badge](https://api.codacy.com/project/badge/Coverage/2c7333e690454bbd99811c8860f08d2b)](https://www.codacy.com/app/msdundar/nokul?utm_source=github.com&utm_medium=referral&utm_content=omu/nokul&utm_campaign=Badge_Coverage) [![Known Vulnerabilities](https://snyk.io/test/github/omu/nokul/badge.svg)](https://snyk.io/test/github/omu/nokul)

## Prerequisites

- [NodeJS (>=10.x)](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
- [Yarn](https://yarnpkg.com/lang/en/docs/install/#debian-stable)
- [Redis](https://packages.debian.org/search?keywords=redis)

## Setup

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
rake db:setup
```

- If you are setting up again, when you already have previous databases:

```bash
rake db:reset
```

`reset` is equivalent of `rake db:drop & rake db:setup`.

- [IN PRODUCTION]. Generate secrets for the app and define them as SECRET_KEY_BASE environment variable:

```bash
RAILS_ENV=production rake secret
export SECRET_KEY_BASE=GENERATED_SECRET_VALUE
```

## HowTo

See [Wiki pages](https://github.com/omu/nokul-bati/wiki) for how-to documents.

## Code Quality

- Rake task named as 'quality' checks for code smells.

```bash
rake quality:ruby # rubocop [ruby] + rubycritic [with reek]
rake quality:rails # rubocop [ruby + rails]
rake quality:all # ruby and rails tasks together
```

## Security

- Rake task named as 'security' checks for security issues:

```bash
rake security:all # runs bundler-audit and brakeman
```

## Tests

Run tests with:

```bash
rake test
```

## Test Coverage

Currently coverage reports are being send to Codacy automatically in CI environment. If you would like to generate a local report for yourself (using SimpleCov), you simply need to run tests and view the generated file in `coverage/index.html.erb`:

```ruby
rake test
```

## Rake Tasks

- [OPTIONAL]. `setup` or `seed` already does it, but if you want to externally create YOKSIS references and departments inside your app, run the tasks shown below:

```bash
rake yoksis:fetch_references
rake yoksis:import_departments
```

* `fetch` prefix has used for API operations, `import` prefix has used for local CSV importing operations.

## Third-Parties

Third-party integrations are located under `app/services/foo/v1`. Follow up /docs subfolder (ie. `app/services/foo/v1/docs` for SOAPUI templates.

## Background Jobs

This app heavily uses Sidekiq (as ActiveJob objects) for performing background jobs. Make sure to start sidekiq for processing queues:

```
bundle exec sidekiq -q high -q low
```

**`bundle exec` is not optional here! Otherwise you will receive errors.**.

Sidekiq also provides a fancy [web interface](http://localhost:3000/sidekiq/).

## App Upgrade

```bash
bin/rails app:update
```

**Run only if you know what you are doing!**

## License

Read [LICENSE](LICENSE.md) for details.
