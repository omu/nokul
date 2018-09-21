# frozen_string_literal: true

require 'test_helper'

class ProgressBarTest < ActiveSupport::TestCase
  test 'spawn method spawns a new progress bar' do
    progress_bar = ProgressBar.spawn('Test', 100)
    assert progress_bar.is_a?(ProgressBar::Base)
    assert_equal progress_bar.title, 'Test'
    assert_equal progress_bar.total, 100
  end
end
