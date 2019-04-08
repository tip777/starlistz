class AddParanoiaDeleteatToPersonInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :person_infos, :deleted_at, :datetime
    add_index :person_infos, :deleted_at
  end
end
