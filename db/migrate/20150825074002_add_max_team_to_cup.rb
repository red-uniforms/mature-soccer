class AddMaxTeamToCup < ActiveRecord::Migration
  def change
    add_column :cups, :max_team, :integer
  end
end
