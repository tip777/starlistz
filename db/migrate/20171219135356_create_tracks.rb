class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.references :list, foreign_key: true
      t.string :artist
      t.string :song
      t.text :description
      t.boolean :recommend, default: false, null: false
      t.integer :row_order

      t.timestamps null:false
    end
  end
end
