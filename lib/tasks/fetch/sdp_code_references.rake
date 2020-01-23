# frozen_string_literal: true

namespace :fetch do
  desc 'Fetch SDP code references from Detsis'
  task sdp_code_references: :environment do
    sdp_codes = Xokul::Detsis.sdp_code_references
    progress_bar = ProgressBar.spawn 'Detsis - SDP code references', sdp_codes.size

    sdp_codes.each do |code|
      SdpCode.create(**code)
      progress_bar&.increment
    end
  end
end
