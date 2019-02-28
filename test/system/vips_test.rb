# frozen_string_literal: true

require 'test_helper'

class VipsTest < ActiveSupport::TestCase
  test 'Test vips library' do
    assert_nothing_raised { annote }
  end

  private

  # example from https://github.com/libvips/ruby-vips/blob/master/example/example3.rb
  def annote
    require 'vips'

    im = Vips::Image.new_from_file file_fixture('valid_png_picture.png').to_s
    im.embed 100, 100, 3000, 3000, extend: :mirror
  end
end
