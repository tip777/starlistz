class ItemMusicServiceTableDrop < ActiveRecord::Migration[5.0]
  def change
    drop_table :item_services
    drop_table :music_services
  end
end
