class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :slug, unique: true, index: true
      t.string :name, unique: true, index: true

      t.jsonb :synonyms, default: [], array: true

      t.integer :taggings_count, default: 0
      
      t.timestamps
    end
  end
end
