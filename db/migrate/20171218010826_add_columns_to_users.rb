class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string, null: false, unique: true
    add_column :users, :stripe_acct_id, :string
    add_column :users, :stripe_cus_id, :string
  end
end
