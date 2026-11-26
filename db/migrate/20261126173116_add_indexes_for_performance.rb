class AddIndexesForPerformance < ActiveRecord::Migration[8.1]
  def change
    add_index :posts, :created_at unless index_exists?(:posts, :created_at)
    add_index :comments, [ :post_id, :created_at ] unless index_exists?(:comments, [ :post_id, :created_at ])
  end
end
