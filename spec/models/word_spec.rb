# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Word, type: :model do
  it 'is valid with text' do
    word = build(:word, text: 'Sample')
    word.valid?
    expect(word.errors).to be_blank
  end
end
