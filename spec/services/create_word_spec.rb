# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create Word', type: :system do
  it 'created the word' do
    text = 'pakaian'
    create_word = CreateWord.new(text: text)
    create_word.call
    expect(create_word).to be_success
    word = find_word('pakaian')
    expect(word).to be_present
  end

  it 'returns errors' do
    text = ''
    create_word = CreateWord.new(text: text)
    create_word.call
    expect(create_word).not_to be_success
    expect(create_word.errors).to include 'Kata tidak boleh kosong'
    word = find_word('')
    expect(word).to be_blank
  end

  it 'create the downcase word' do
    text = 'Pakaian'
    create_word = CreateWord.new(text: text)
    create_word.call
    expect(create_word).to be_success
    word = find_word('pakaian')
    expect(word).to be_present
  end

  private

  def find_word(text)
    Word.find_by(text: text)
  end
end
