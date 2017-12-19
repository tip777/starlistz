class CreateListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :list_items do |t|
      t.string :artist
      t.string :song
      t.integer :favorite

      t.timestamps null:false
    end
  end
end
