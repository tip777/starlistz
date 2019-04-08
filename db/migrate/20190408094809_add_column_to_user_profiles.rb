class AddColumnToUserProfiles < ActiveRecord::Migration[5.0]
  def change
    add_reference :user_profiles, :user, foreign_key: true
  end
end
