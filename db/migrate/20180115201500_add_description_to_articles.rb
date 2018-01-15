class AddDescriptionToArticles < ActiveRecord::Migration
  def change
    # Add thre new columns (description, created_at, updated_at) to the Articles table, and its data types.
    add_column :articles, :description, :text
    # Timestamp
    add_column :articles, :created_at, :datetime
    # Timestamp
    add_column :articles, :updated_at, :datetime
  end
end
