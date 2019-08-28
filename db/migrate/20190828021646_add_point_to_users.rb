# frozen_string_literal: true

class AddPointToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :point, :integer, default: 0
  end
end
