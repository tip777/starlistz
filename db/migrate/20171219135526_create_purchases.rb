class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.date :order_date
      t.references :user, foreign_key: true
      t.references :list, foreign_key: true

      t.timestamps null:false
    end
    add_index :purchases, [:user_id, :list_id], unique: true
  end
end
