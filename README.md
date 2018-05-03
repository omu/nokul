# Nokul

[![CircleCI](https://circleci.com/gh/omu/nokul/tree/master.svg?style=svg&circle-token=a25e63abc0e1e6c074750d9b2ce5396e3e279d82)](https://circleci.com/gh/omu/nokul/tree/master) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/6578e7454b81431aa0e0fe74e9cce9c9)](https://www.codacy.com?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=omu/nokul&amp;utm_campaign=Badge_Grade)

## Setup

- You must have an up-to-dated JS interpreter (preferably NodeJS) installed on your system in order to run Rails applications:

```bash
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
```

- Database configuration file reads username, password and host settings from environment variables. Make sure to define these environment variables before setting up the project:

```
RDS_USERNAME: PostgreSQL username
RDS_PASSWORD: PostgreSQL password
RDS_HOSTNAME: PostgreSQL hostname (probably localhost)
YOKSIS_USER: YOKSIS username.
YOKSIS_PASSWORD: YOKSIS password.
```

- Install dependencies:

```bash
bundle
```

- Create databases and migration tables:

```bash
rake db:setup
```

- [OPTIONAL]. If you want to create YOKSIS departments inside your app, run the task shown below:

```bash
rake yoksis:referanslar:all
rake yoksis:departments
```

- [IN PRODUCTION]. Generate secrets for the app and define them as SECRET_KEY_BASE environment variable:

```bash
RAILS_ENV=production rake secret
export SECRET_KEY_BASE=GENERATED_SECRET_VALUE
```

## HowTo

See [Wiki pages](https://github.com/omu/nokul-bati/wiki) for how-to documents.

## Design

![model-diagrams](http://i65.tinypic.com/23u370m.png)

## Code Quality

- Rake task named as 'quality' checks for code smells.

```bash
rake quality:ruby # runs rubocop and checks only for ruby offenses & runs rubycritic (rubycritic includes reek!)
rake quality:rails # runs rubocop and checks both for ruby and rails offenses
rake quality:all # runs both ruby and rails tasks.
```

- Rake task named as 'security' checks for security issues:

```bash
rake security:all # runs bundler-audit and brakeman
```

## Tests

Run tests with:

```bash
rake test
```

## Third-Parties

Third-party integrations are located under `app/services/foo/v1`. Follow up /docs subfolder (ie. `app/services/foo/v1/docs` for SOAPUI templates.

## App Upgrade


```bash
bin/rails app:update
```

**Run only if you know what you are doing!**

## License

Read [LICENSE](LICENSE.md) for details.
