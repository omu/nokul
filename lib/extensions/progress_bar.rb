# frozen_string_literal: true

require 'ruby-progressbar/outputs/null'

class ProgressBar
  def self.spawn(title, total, output = $stdout)
    ProgressBar.create(title: title, total: total, format: '%t %B %c/%C %a', output: output)
  end
end
