# frozen_string_literal: true

module Xokul
  class Yoksis
    include Graduates
    include Military
    include References
    include Resumes
    include Staff
    include Students
    include Units

    def initialize(client)
      @client = client
    end
  end
end
