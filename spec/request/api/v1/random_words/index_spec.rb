# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Random word index API', type: :request do
  it 'returns random word data' do
    create(:word, text: 'sample')
    get '/api/v1/random_words'
    data = JSON.parse(response.body)
    expect(data['id']).to be_present
    expect(data['random_word']).to be_present
  end
end
