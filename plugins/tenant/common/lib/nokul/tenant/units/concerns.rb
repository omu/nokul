# frozen_string_literal: true

# A single unit (One) or multiple units (Many) can take two forms, Raw or Src;
# hence there are 4 concerns: raw_many, raw_one, src_many, src_one.  All *_many
# and *_one inherit from the internal many and one concerns respectively.

require_relative 'concerns/raw_one'
require_relative 'concerns/raw_many'
require_relative 'concerns/src_one'
require_relative 'concerns/src_many'
