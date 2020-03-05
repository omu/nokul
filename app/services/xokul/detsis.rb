# frozen_string_literal: true

module Xokul
  module Detsis
    module_function

    def sdp_code_references
      Connection.request '/detsis/sdp_code_references'
    end
  end
end
