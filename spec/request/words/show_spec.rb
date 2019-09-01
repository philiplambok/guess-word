# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Words index API', type: :request do
  it 'returns word data json' do
    word = create(:word, text: 'sample')
    get "/api/v1/words/#{word.id}"
    json = JSON.parse(response.body)
    expect(json['id']).to eq word.id
    expect(json['text']).to eq 'sample'
  end

  it 'returns error not found' do
    get '/api/v1/words/9999'
    json = JSON.parse(response.body)
    expect(json['error']['code']).to eq 404
    expect(json['error']['message']).to eq 'Word not found'
  end
end
