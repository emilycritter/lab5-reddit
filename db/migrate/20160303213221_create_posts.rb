class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :vote_count
      t.integer :user_id
      t.string :photo_id
      t.string :link_url

      t.timestamps null: false
    end
  end
end
