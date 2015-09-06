class CreateReferees < ActiveRecord::Migration
  def change
    create_table :referees do |t|
      t.belongs_to :match
      t.belongs_to :organizer

      t.timestamps null: false
    end
  end
end
