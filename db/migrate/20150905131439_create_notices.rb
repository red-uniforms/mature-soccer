class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title
      t.text :text
      t.belongs_to :cup

      t.timestamps null: false
    end
  end
end
