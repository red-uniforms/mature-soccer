class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.belongs_to :cup

      t.timestamps null: false
    end

    change_table :teams do |t|
      t.belongs_to :group
    end
  end
end
