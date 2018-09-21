# frozen_string_literal: true

class ProgressBar
  def self.spawn(title, total)
    ProgressBar.create(title: title, total: total, format: '%t %B %c/%C %a')
  end
end
