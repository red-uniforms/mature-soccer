class AddDescriptionToCup < ActiveRecord::Migration
  def change
    add_column :cups, :description, :string
    add_column :cups, :has_league, :boolean
    add_column :cups, :has_tournament, :boolean

    remove_column :cups, :competition_format
  end
end
