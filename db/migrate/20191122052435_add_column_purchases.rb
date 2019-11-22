class AddColumnPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :purchase_price, :integer
  end
end
