# frozen_string_literal: true

class AddDeletedAtToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :deleted_at, :datetime, after: :updated_at
  end
end
