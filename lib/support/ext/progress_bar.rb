# frozen_string_literal: true

class ProgressBar
  def self.spawn(title, total, output = $stdout)
    ProgressBar.create(title: title, total: total, format: '%t %B %c/%C %a', output: output) if Rails.env.development?
  end
end
