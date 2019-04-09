class CreatePersonInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :person_infos do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.date :birthday
      t.string :zipcode
      # t.string :prefecture
      t.references :prefecture, foreign_key: true
      t.string :city
      t.string :address1
      t.string :address2
      t.string :phone_number
      
      t.timestamps
    end
    
  end
end
