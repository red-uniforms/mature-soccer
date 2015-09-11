class AddHomeGoalToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :home_goal, :integer, :default => 0
    add_column :matches, :away_goal, :integer, :default => 0
  end
end
