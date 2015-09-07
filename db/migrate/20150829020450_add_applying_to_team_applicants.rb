class AddApplyingToTeamApplicants < ActiveRecord::Migration
  def change
    add_column :team_applicants, :applying, :boolean, :default => true
  end
end
