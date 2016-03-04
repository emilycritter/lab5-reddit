class AddDefaults < ActiveRecord::Migration
  def change
    remove_column :posts, :vote_count
    add_column :posts, :vote_count, :integer, default: 0
  end
end
