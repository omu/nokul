# frozen_string_literal: true

require 'test_helper'

Dir['plugins/**/test/**/*_test.rb'].each { |file| load file }
