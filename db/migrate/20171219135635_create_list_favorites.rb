class CreateListFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :list_favorites do |t|
      t.references :list, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null:false
    end
  end
end
