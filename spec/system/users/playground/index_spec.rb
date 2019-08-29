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
    let(:user) { create(:user, name: 'Philip Lambok', point: 0) }

    before do
      create(:word, text: 'sample')
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
      expect(page).to have_content 'BENAR, point anda menjadi 1'
      expect(page).to have_field('guess_word', with: '')
    end

    it 'returns error message' do
      fill_in :guess_word, with: 'wrongs'
      click_on 'Submit'
      expect(page).to have_content 'SALAH! Silahkan coba lagi'
    end

    it 'redirect_to abouts_path if click about link' do
      click_on 'About'
      expect(page).to have_current_path abouts_path
    end

    it 'make point to zero when click reset button' do
      fill_in :guess_word, with: 'sample'
      click_on 'Submit'
      expect(page).to have_content '1 points'
      click_on 'Reset'
      expect(page).to have_content '0 points'
      # We also ensure user's point in database was updated
      visit user_playground_index_path(user)
      expect(page).to have_content '0 points'
    end

    it 'increments the point when input word was correct' do
      expect(page).to have_content '0 points'
      fill_in :guess_word, with: 'sample'
      click_on 'Submit'
      expect(page).to have_content '1 points'
      fill_in :guess_word, with: 'sample'
      click_on 'Submit'
      expect(page).to have_content '2 points'
      # We also enscure user's point in database also updated
      visit user_playground_index_path(user)
      expect(page).to have_content '2 points'
    end
  end
end
