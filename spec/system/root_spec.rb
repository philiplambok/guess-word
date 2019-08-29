# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome page spec', type: :system, js: true do
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

  it 'redirect_to abouts_path when about link was clicked' do
    click_on 'About'
    expect(page).to have_current_path abouts_path
  end

  it 'redirect_to ranking_path when ranking link was clicked' do
    click_on 'Ranking'
    expect(page).to have_current_path rankings_path
  end

  it 'redirect to playground page when submit valid name' do
    fill_in :user_name, with: 'Philip Lambok'
    click_on 'Mulai Bermain'
    expect(page).to have_title "Philip Lambok's playground"
  end

  it 'will continue the game when name was registered' do
    create(:user, name: 'pquest', point: 10)
    fill_in :user_name, with: 'pquest'
    click_on 'Mulai Bermain'
    expect(page).to have_title "pquest's playground"
    expect(page).to have_content '10 points'
  end

  it 'returns error message when submit invalid name' do
    fill_in :user_name, with: ''
    click_on 'Mulai Bermain'
    expect(page).to have_content 'Nama tidak boleh kosong'
  end
end
