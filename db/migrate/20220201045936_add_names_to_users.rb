# frozen_string_literal: true

class AddNamesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string, null: false, after: :id
    add_column :users, :last_name, :string, null: false, after: :first_name
    add_column :users, :nick_name, :string, null: false, after: :last_name
  end
end
