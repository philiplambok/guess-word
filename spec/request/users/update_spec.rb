# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Update API', type: :request do
  it 'returns updated user data' do
    user = create(:user, point: 0)
    put "/api/v1/users/#{user.id}", params: { user: { point: 1 } }
    json = JSON.parse(response.body)
    expect(json['point']).to eq 1
  end

  it 'returns error message when user not found' do
    invalid_user_id = 999
    put "/api/v1/users/#{invalid_user_id}", params: { user: { point: 1 } }
    json = JSON.parse(response.body)
    expect(json['error']).to eq 'User not found'
  end
end
