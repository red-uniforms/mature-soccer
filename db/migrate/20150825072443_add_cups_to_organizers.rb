class AddCupsToOrganizers < ActiveRecord::Migration
  def change
    change_table :organizers do |t|
      t.belongs_to :cup
    end

    drop_table :cups_organizers
  end
end
