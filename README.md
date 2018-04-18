# Nokul

[![CircleCI](https://circleci.com/gh/omu/nokul-bati/tree/master.svg?style=svg&circle-token=a25e63abc0e1e6c074750d9b2ce5396e3e279d82)](https://circleci.com/gh/omu/nokul-bati/tree/master) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/0a5883e47b8d4ef88d5678a0214081ea)](https://www.codacy.com?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=omu/nokul-bati&amp;utm_campaign=Badge_Grade)

## Setup

- Database configuration file reads username, password and host settings from environment variables.

Make sure to define these environment variables before setting up the project:

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

- Create databases and migrate tables:

```bash
rake db:setup
```

- [OPTIONAL]. If you want to create YOKSIS departments inside your app, run the task shown below:

```bash
rake yoksis:departments
rake yoksis:referanslar:pozisyonlar
```

## HowTo

See [Wiki pages](https://github.com/omu/nokul-bati/wiki) for how-to documents.

## Design

![model-diagrams](http://i65.tinypic.com/23u370m.png)

## Code Quality

- Rake task named as 'quality' checks for code smells.

```bash
rake quality:ruby # rubocop (checks only ruby offenses) and reek
rake quality:rails # rubocop (checks ruby and rails offenses) and rubycritic
rake quality:all # both ruby and rails.
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
