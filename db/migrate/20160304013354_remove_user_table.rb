class RemoveUserTable < ActiveRecord::Migration
  def change
    drop_table :users
    add_column :posts, :added_by, :string
    remove_column :posts, :user_id, :integer
  end
end
