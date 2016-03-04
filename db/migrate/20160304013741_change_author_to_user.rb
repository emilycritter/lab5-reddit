class ChangeAuthorToUser < ActiveRecord::Migration
  def change
    drop_table :authors
    create_table :users do |t|
    t.string :name
  end
  end
end
