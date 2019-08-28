# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RandomWord do
  it 'returns randow word of passed word' do
    sample_word = 'buku'
    random_word_service = RandomWord.new(sample_word)
    random_word_service.generate
    expect(random_word_service.random_word).to be_present
    expect(random_word_service.random_word).not_to eq 'buku'
  end

  it 'returns passed word if size of passed word is one char' do
    sample_word = 'a'
    random_word_service = RandomWord.new(sample_word)
    random_word_service.generate
    expect(random_word_service.random_word).to eq 'a'
  end

  it 'returns empty char if passed word was nil' do
    sample_word = nil
    random_word_service = RandomWord.new(sample_word)
    random_word_service.generate
    expect(random_word_service.random_word).to eq ''
  end

  it 'returns empty char if passed word was empty' do
    sample_word = ''
    random_word_service = RandomWord.new(sample_word)
    random_word_service.generate
    expect(random_word_service.random_word).to eq ''
  end

  it 'returns expected random word if size of passed word is 2 chars' do
    sample_word = 'ab'
    random_word_service = RandomWord.new(sample_word)
    random_word_service.generate
    expect(random_word_service.random_word).to eq 'ba'
  end
end
