class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.text :name
      t.text :email
      t.text :title
      t.text :message
      t.timestamps
    end
  end
end
