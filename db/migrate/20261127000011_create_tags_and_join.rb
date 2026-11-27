class CreateTagsAndJoin < ActiveRecord::Migration[8.1]
  def change
    unless table_exists?(:tags)
      create_table :tags do |t|
        t.string :name, null: false
        t.string :slug, null: false
        t.timestamps
      end
      add_index :tags, :slug, unique: true unless index_exists?(:tags, :slug)
    end

    unless table_exists?(:post_tags)
      create_table :post_tags do |t|
        t.references :post, null: false, foreign_key: true
        t.references :tag, null: false, foreign_key: true
        t.timestamps
      end
      add_index :post_tags, [ :post_id, :tag_id ], unique: true unless index_exists?(:post_tags, [ :post_id, :tag_id ])
    end
  end
end
