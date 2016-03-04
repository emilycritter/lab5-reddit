class AdjustCommentAndUserTable < ActiveRecord::Migration
  def change
    remove_column :comments, :author_id
    add_column :comments, :author, :string
    add_column :posts, :user_id, :integer
  end
end
