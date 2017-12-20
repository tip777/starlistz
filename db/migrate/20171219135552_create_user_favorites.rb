class CreateUserFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :user_favorites do |t|
      t.integer :favoriter_id
      t.integer :favorited_id
      t.timestamps null: false
    end
      # t.index [:favoriter_id, :favorited_id], unique: true
      add_index :user_favorites, :favoriter_id
      add_index :user_favorites, :favorited_id
      add_index :user_favorites, [:favoriter_id, :favorited_id], unique: true
    
  end
end
