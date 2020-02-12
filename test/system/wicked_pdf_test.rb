# frozen_string_literal: true

require 'test_helper'

class WickedPDFTest < ActiveSupport::TestCase
  test 'Create a test pdf from a string' do
    assert WickedPdf.new.pdf_from_string 'lorem ipsum ibi libertas'
  end
end
