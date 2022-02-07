class CreateGems < ActiveRecord::Migration[7.0]
  def change
    create_table :gems, id: :uuid do |t|
      t.string :type, default: "Gemm"
      
      t.string :slug
      t.string :name
      t.text :title
      t.text :description
      
      t.string :version
      t.string :platform
      
      t.jsonb :details, default: {}

      t.jsonb :authors, default: [], array: true
      t.jsonb :licenses, default: [], array: true

      t.integer :likes_count, default: 0
      t.integer :downloads_count, default: 0

      t.timestamp :built_at
      t.timestamps
    end
    add_index :gems, :slug
    add_index :gems, :name
  end
end
