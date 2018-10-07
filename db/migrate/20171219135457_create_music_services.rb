class CreateMusicServices < ActiveRecord::Migration[5.0]
  def change
    create_table :music_services do |t|
      t.string :name
      t.text :url

      t.timestamps null:false
    end
  end
end
