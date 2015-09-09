class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :when
      t.integer :time
      t.string :event_type
      t.belongs_to :user
      t.belongs_to :match

      t.timestamps null: false
    end

    change_table :matches do |t|
      t.datetime :started_at
      t.string :status, default: "0"
    end
  end
end
