# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with name' do
    user = build(:user, name: 'Philip')
    user.valid?
    expect(user.errors).to be_blank
  end

  it 'is invalid without name' do
    user = build(:user, name: '')
    user.valid?
    expect(user.errors.full_messages).to include 'Nama tidak boleh kosong'
  end
end
