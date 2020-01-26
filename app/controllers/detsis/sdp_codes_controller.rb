# frozen_string_literal: true

module Detsis
  class SdpCodesController < ApplicationController
    include SearchableModule

    def index
      @sdp_codes = pagy_by_search(SdpCode.order(:main))
    end
  end
end
