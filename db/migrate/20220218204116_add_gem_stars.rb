class AddGemStars < ActiveRecord::Migration[7.0]
  def change
    add_column :gems, :forks_count, :integer, default: 0
    add_column :gems, :stars_count, :integer, default: 0
    add_column :gems, :watchers_count, :integer, default: 0

    add_index :gems, :forks_count
    add_index :gems, :stars_count
    add_index :gems, :watchers_count
    add_index :gems, :tags_count
    add_index :gems, :likes_count
    add_index :gems, :downloads_count
  end
end
