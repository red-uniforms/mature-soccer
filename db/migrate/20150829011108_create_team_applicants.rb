class CreateTeamApplicants < ActiveRecord::Migration
  def change
    create_table :team_applicants do |t|
      t.belongs_to :team
      t.belongs_to :cup
      
      t.timestamps null: false
    end
  end
end
