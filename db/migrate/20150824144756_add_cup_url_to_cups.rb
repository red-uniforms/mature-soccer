class AddCupUrlToCups < ActiveRecord::Migration
  def change
    add_reference :cups, :team, index: true

    add_column :cups, :competition_format ,:string
    add_column :cups, :name, :string
    add_column :cups, :cup_url, :string

    add_index :cups, :cup_url,  unique: true

    create_table :cups_teams, id: false do |t|
      t.belongs_to :cup, index: true
      t.belongs_to :team, index: true
    end
  end
end
