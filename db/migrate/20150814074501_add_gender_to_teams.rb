class AddGenderToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :gender, :string
    add_column :teams, :average_age, :integer
  end
end
