class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.integer :price

      t.timestamps null: false
    end
  end
end
