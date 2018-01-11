class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.references :list, foreign_key: true
      t.string :artist
      t.string :song
      t.integer :recommend
      t.integer :no

      t.timestamps null:false
    end
  end
end
