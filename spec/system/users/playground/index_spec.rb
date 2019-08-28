# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "User's playground", type: :system, js: true do
  context 'when user doesnt exist' do
    it 'redirect to root_path' do
      visit '/users/999/playground'
      expect(page).to have_current_path root_path
    end
  end

  context 'when user exist' do
    before do
      create(:word, text: 'sample')
      user = create(:user, name: 'Philip Lambok')
      visit user_playground_index_path(user)
    end

    it 'returns expected title' do
      expect(page).to have_title "Philip Lambok's playground"
    end

    it 'returns initials points of user' do
      expect(page).to have_content '0 points'
    end

    it 'returns name of user' do
      expect(page).to have_content 'Philip Lambok'
    end

    it 'returns random words' do
      random_word = page.find('#random-word')
      expect(random_word.text).to be_present
    end

    it 'returns sucess message' do
      fill_in :guess_word, with: 'sample'
      click_on 'Submit'
      expect(page).to have_content 'BENAR point anda menjadi 1'
    end
  end
end
