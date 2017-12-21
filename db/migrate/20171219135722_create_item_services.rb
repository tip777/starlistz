class CreateItemServices < ActiveRecord::Migration[5.0]
  def change
    create_table :item_services do |t|
      t.references :music_service, foreign_key: true
      t.references :list_item, foreign_key: true

      t.timestamps null:false
    end
  end
end
