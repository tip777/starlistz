class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.integer :price
      t.string :status, null: false, default: "closed"

      t.timestamps null: false
    end
  end
end
