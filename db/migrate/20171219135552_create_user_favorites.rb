class CreateUserFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :user_favorites do |t|
      t.references :favoriting, foreign_key: true
      t.references :fovorited, foreign_key: true

      t.timestamps null: false
      t.index [:favoriting_id, :favorited_id], unique: true
    end
  end
end
