class CreateTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :taggings, id: :uuid do |t|
      t.references :gem, null: false, foreign_key: true, type: :uuid
      t.references :tag, null: false, foreign_key: true, type: :uuid
      t.timestamps
      t.index ["gem_id", "tag_id"], unique: true
    end
  end
end
