# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.bigint :user_id, null: false
      t.text :content, null: false
      t.bigint :parent_id

      t.timestamps
    end
  end
end
