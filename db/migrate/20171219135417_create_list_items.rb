class CreateListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :list_items do |t|
      t.references :list, foreign_key: true
      t.string :artist
      t.string :song
      t.integer :recommend

      t.timestamps null:false
    end
  end
end
