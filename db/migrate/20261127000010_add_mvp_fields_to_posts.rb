class AddMvpFieldsToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :slug, :string unless column_exists?(:posts, :slug)
    add_column :posts, :subtitle, :string unless column_exists?(:posts, :subtitle)
    add_column :posts, :excerpt, :text unless column_exists?(:posts, :excerpt)
    add_column :posts, :status, :string, default: "draft", null: false unless column_exists?(:posts, :status)
    add_column :posts, :published_at, :datetime unless column_exists?(:posts, :published_at)
    add_column :posts, :seo_title, :string unless column_exists?(:posts, :seo_title)
    add_column :posts, :seo_description, :text unless column_exists?(:posts, :seo_description)
    add_column :posts, :user_id, :bigint unless column_exists?(:posts, :user_id)
    add_column :posts, :category_id, :bigint unless column_exists?(:posts, :category_id)

    add_index :posts, :slug, unique: true unless index_exists?(:posts, :slug)
    add_index :posts, :status unless index_exists?(:posts, :status)
    add_index :posts, :published_at unless index_exists?(:posts, :published_at)
    add_index :posts, :category_id unless index_exists?(:posts, :category_id)
    add_index :posts, :user_id unless index_exists?(:posts, :user_id)

    add_foreign_key :posts, :categories unless foreign_key_exists?(:posts, :categories)
    add_foreign_key :posts, :users unless foreign_key_exists?(:posts, :users)

    # Ensure a default category exists and backfill posts without one
    reversible do |dir|
      dir.up do
        execute "INSERT INTO categories (name, slug, description, created_at, updated_at) SELECT 'General','general','General interest posts', NOW(), NOW() WHERE NOT EXISTS (SELECT 1 FROM categories WHERE slug='general')"
        execute "UPDATE posts SET category_id = (SELECT id FROM categories WHERE slug='general') WHERE category_id IS NULL"
      end
    end
  end
end
