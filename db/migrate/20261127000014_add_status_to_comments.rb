class AddStatusToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :status, :string, default: "approved", null: false unless column_exists?(:comments, :status)
    add_index :comments, :status unless index_exists?(:comments, :status)
  end
end
