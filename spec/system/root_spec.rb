# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome page spec', type: :system do
  before do
    visit root_path
  end

  it 'returns expected title' do
    expect(page).to have_title 'Guess Word Game'
  end

  it 'returns welcome text' do
    expect(page).to have_text 'Welcome to'
    expect(page).to have_text 'guess-word game'
  end

  it 'redirect to playground page when submit valid name' do
    fill_in :user_name, with: 'Philip Lambok'
    click_on 'Mulai Bermain'
    expect(page).to have_title "Philip Lambok's playground"
  end

  it 'returns error message when submit invalid name' do
    fill_in :user_name, with: ''
    click_on 'Mulai Bermain'
    expect(page).to have_content 'Nama tidak boleh kosong'
  end
end
