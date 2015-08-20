class AddUniformDescriptionToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :uniform_description, :text
  end
end
