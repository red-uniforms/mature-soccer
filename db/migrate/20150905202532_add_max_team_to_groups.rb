class AddMaxTeamToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :max_team, :integer
  end
end
