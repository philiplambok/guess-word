# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Add new word', type: :system do
  before do
    visit new_word_path
  end

  it 'redirect_to root_path' do
    click_on 'Kembali ke halaman awal'
    expect(page).to have_current_path root_path
  end

  it 'returns expected title' do
    expect(page).to have_title 'Menambahkan Kata Baru'
  end

  it 'returns error message' do
    fill_in :word_text, with: ''
    click_on 'Tambahkan'
    within '.alert' do
      expect(page).to have_content 'Kata tidak boleh kosong'
    end
  end

  it 'returns success message' do
    fill_in :word_text, with: 'ilmu'
    click_on 'Tambahkan'
    expect(page).to have_content 'Kata berhasil ditambahkan, terima kasih telah berkontribusi'
  end
end
