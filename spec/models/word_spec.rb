# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Word, type: :model do
  it 'is valid with text' do
    word = build(:word, text: 'Sample')
    word.valid?
    expect(word.errors).to be_blank
  end

  it 'is invalid without text' do
    word = build(:word, text: nil)
    word.valid?
    expect(word.errors[:text]).to include 'tidak boleh kosong'
  end

  it 'is invalid with duplicate word' do
    create(:word, text: 'baju')
    word = build(:word, text: 'baju')
    word.valid?
    expect(word.errors[:text]).to include 'sudah pernah ditambahkan'
  end

  it 'is invalid when text includes whitespace' do
    word = build(:word, text: 'sebuah kalimat')
    word.valid?
    expect(word.errors[:text]).to include 'tidak boleh mengandung spasi'
  end

  it 'is invalid when text less than 3 characters' do
    text = 'a' * 2
    word = build(:word, text: text)
    word.valid?
    expect(word.errors[:text]).to include 'harus memiliki panjang karakter 3 - 20'
  end

  it 'is valid when text have 20 characters' do
    text = 'a' * 20
    word = build(:word, text: text)
    word.valid?
    expect(word.errors).to be_blank
  end

  it 'is invalid when text more that 20 characters' do
    text = 'a' * 21
    word = build(:word, text: text)
    word.valid?
    expect(word.errors[:text]).to include 'harus memiliki panjang karakter 3 - 20'
  end

  it 'is invalid when text includes symbol' do
    text = 'kata$'
    word = build(:word, text: text)
    word.valid?
    expect(word.errors[:text]).to include 'tidak boleh mengandung simbol'
  end

  it 'is invalid when text includes numeric' do
    word = build(:word, text: 'kata2')
    word.valid?
    expect(word.errors[:text]).to include 'tidak boleh mengandung angka'
  end
end
