# frozen_string_literal: true

class AddUserIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :user_id, :bigint, null: false
  end
end
