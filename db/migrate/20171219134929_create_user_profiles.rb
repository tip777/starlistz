class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.text :insta_url
      t.text :tw_url

      t.timestamps null: false
    end
  end
end
