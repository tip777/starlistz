class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string, null: false, unique: true
    add_column :users, :stripe_acct_id, :string
    add_column :users, :stripe_cus_id, :string
    add_column :users, :stripe_acct_secret, :text
    add_column :users, :secret_key, :text
    add_column :users, :identity, :string
    add_column :users, :tos_acceptance, :boolean
    add_column :users, :tos_acceptance_date, :date
  end
end
