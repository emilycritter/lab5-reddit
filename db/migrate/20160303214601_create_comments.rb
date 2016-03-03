class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.text :comment_text
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
