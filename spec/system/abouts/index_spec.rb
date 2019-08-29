# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'About index', type: :system do
  it 'returns expected title' do
    visit abouts_path
    expect(page).to have_title 'Tentang Program'
  end
end
