class CreatePostLikes < ActiveRecord::Migration[8.1]
  def change
    unless table_exists?(:post_likes)
      create_table :post_likes do |t|
        t.references :user, null: false, foreign_key: true
        t.references :post, null: false, foreign_key: true
        t.timestamps
      end
      add_index :post_likes, [ :user_id, :post_id ], unique: true unless index_exists?(:post_likes, [ :user_id, :post_id ])
    end
  end
end
