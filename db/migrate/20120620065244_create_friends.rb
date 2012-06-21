class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :id
      t.string :name
      t.string :surname
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
