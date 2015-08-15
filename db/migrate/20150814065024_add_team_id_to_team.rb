class AddTeamIdToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :team_url, :string

    add_index :teams, :team_url,                unique: true
  end
end
