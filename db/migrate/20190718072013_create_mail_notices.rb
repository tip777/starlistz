class CreateMailNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :mail_notices do |t|
      t.references :user, foreign_key: true
      t.boolean :news_letter, null: false, default: true
      t.boolean :list_sold, null: false, default: true

      t.timestamps
    end
  end
end
