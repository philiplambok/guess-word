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
end
