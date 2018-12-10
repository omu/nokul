## TL;DR

- Do not use `limit: N` on integers.

### Primary Keys and Foreign Keys

- Starting from Rails 5.1, primary ID's are bigint (8bytes, maximum: 9,223,372,036,854,775,807) by default. Therefore, foreign_keys referencing them have to be bigint too.

### Integer Without a Limit

- Integer without a limit produces int(4 bytes, max 2,147,483,647)

### Integer with Limit

- Integer with `limit: 1` produces tinyint (1 byte, -128 to 127)
- Integer with `limit: 2` produces smallint (2 bytes, max 32,767)
- Integer with `limit: 3` produces mediumint (3 bytes, max 8,388,607)
- Integer with `limit: 4` produces int(4 bytes, max 2,147,483,647)
- Integer with `limit: 8` produces bigint (8 bytes, max 9,223,372,036,854,775,807)

After this point, any bigger limit will fallback to 4 bytes:

- Integer with `limit: 9` produces int(4 bytes, max 2,147,483,647)
- Integer with `limit: 11` produces int(4 bytes, max 2,147,483,647)
- Integer with `limit: 100` produces int(4 bytes, max 2,147,483,647)

### References

- https://gist.github.com/icyleaf/9089250
- https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html
- https://github.com/rails/rails/blob/master/activerecord/lib/active_record/connection_adapters/postgresql_adapter.rb
- https://stackoverflow.com/questions/38053596/benchmark-bigint-vs-int-on-postgresql
- https://stackoverflow.com/questions/2966524/calculating-and-saving-space-in-postgresql/7431468#7431468
