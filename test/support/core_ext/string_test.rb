# frozen_string_literal: true

require 'test_helper'

class StringTest < ActiveSupport::TestCase
  test 'titleize_tr method can titleize sentences in Turkish' do
    sentences = {
      'ışık ılık süt iç' => 'Işık Ilık Süt İç',
      'İşik ILIK sÜt (iç)' => 'İşik Ilık Süt (İç)',
      'foo "bar"' => 'Foo "Bar"',
      'Işık süt ve BALI karıŞtıRarak /İÇ' => 'Işık Süt ve Balı Karıştırarak /İç'
    }

    sentences.each do |senctence, expected|
      assert_equal senctence.titleize_tr, expected
    end
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
