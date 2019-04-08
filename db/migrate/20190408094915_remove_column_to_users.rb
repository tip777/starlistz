class RemoveColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :users, :user_profile, foreign_key: true
  end
end
