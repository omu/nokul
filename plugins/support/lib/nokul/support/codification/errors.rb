# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      Error    = Class.new ::StandardError
      Consumed = Class.new ::StandardError
      Skip     = Class.new ::StopIteration
    end
  end
end
