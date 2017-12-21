class CreateListContents < ActiveRecord::Migration[5.0]
  def change
    create_table :list_contents do |t|
      t.references :list, foreign_key: true
      t.references :list_item, foreign_key: true

      t.timestamps null:false
    end
  end
end
