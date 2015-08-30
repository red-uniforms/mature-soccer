class CreateCaptains < ActiveRecord::Migration
  def change
    create_table :captains do |t|
      t.belongs_to :user
      t.belongs_to :team

      t.timestamps null: false
    end
  end
end
