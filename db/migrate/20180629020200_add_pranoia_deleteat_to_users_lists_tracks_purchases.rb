class AddPranoiaDeleteatToUsersListsTracksPurchases < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
    
    add_column :user_profiles, :deleted_at, :datetime
    add_index :user_profiles, :deleted_at
    
    add_column :person_infos, :deleted_at, :datetime
    add_index :person_infos, :deleted_at
    
    add_column :lists, :deleted_at, :datetime
    add_index :lists, :deleted_at
    
    add_column :tracks, :deleted_at, :datetime
    add_index :tracks, :deleted_at
    
    add_column :purchases, :deleted_at, :datetime
    add_index :purchases, :deleted_at
  end
end
