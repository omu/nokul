# frozen_string_literal: true

require 'test_helper'

class StringTest < ActiveSupport::TestCase
  test 'capitalize_all method can capitalize words in Turkish' do
    word = 'ışık ılık süt iç'
    assert_equal word.capitalize_all, 'Işık Ilık Süt İç'
  end

  test 'upcase_tr method can upcase words in Turkish' do
    word = 'ışık ılık süt iç'
    assert_equal word.upcase_tr, 'IŞIK ILIK SÜT İÇ'
  end

  test 'abbreviation method can generate abbreviations for words in Turkish' do
    word = 'istanbul ışık üniversitesi'
    assert_equal word.abbreviation, 'İIÜ'
  end
end
