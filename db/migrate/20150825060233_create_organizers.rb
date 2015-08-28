class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.belongs_to :user
      t.timestamps null: false
    end

    create_table :cups_organizers do |t|
      t.belongs_to :cup, index: true
      t.belongs_to :organizer, index: true
    end

    change_table :cups do |t|
      t.timestamps
    end
  end
end
