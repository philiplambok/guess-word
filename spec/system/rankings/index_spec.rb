# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ranking index', type: :system do
  it 'returns expected title' do
    visit rankings_path
    expect(page).to have_title 'Ranking'
  end

  it 'returns ordered users' do
    create(:user, name: 'pquest', point: 10)
    create(:user, name: 'ainz', point: 4)
    create(:user, name: 'kano', point: 7)
    visit rankings_path
    within 'thead' do
      column_names = '# Name Point'
      expect(page).to have_text column_names
    end
    within 'tbody' do
      within 'tr:nth-child(1)' do
        expect(page).to have_text '1 pquest 10'
      end
      within 'tr:nth-child(2)' do
        expect(page).to have_content '2 kano 7'
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content '3 ainz 4'
      end
    end
  end

  it 'redirect to root_path if click Mulai bermain link' do
    visit rankings_path
    click_on 'mulai bermain'
    expect(page).to have_current_path root_path
  end
end
