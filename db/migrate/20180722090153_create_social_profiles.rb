class CreateSocialProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :social_profiles do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :name
      t.string :nickname
      t.string :email
      t.string :url
      t.integer :followers_count

      t.timestamps
    end

    add_index :social_profiles, [:provider, :uid], unique: true

  end
end
