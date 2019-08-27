# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome page spec', type: :system do
  it 'returns welcome text' do
    visit root_path
    expect(page).to have_content 'Welcome to guess-word game'
  end

  context 'with valid params' do
    it 'redirect to playground page' do
      visit root_path
      fill_in :user_name, with: 'Philip Lambok'
      click_on 'Mulai Bermain'
      expect(page).to have_title "Philip Lambok's playground"
    end
  end

  context 'with invalid params' do
    it 'returns error message' do
      visit root_path
      fill_in :user_name, with: ''
      click_on 'Mulai Bermain'
      expect(page).to have_content 'Nama tidak boleh kosong'
    end
  end
end
