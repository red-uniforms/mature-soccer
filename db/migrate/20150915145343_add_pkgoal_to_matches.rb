class AddPkgoalToMatches < ActiveRecord::Migration
  def change
    change_table :matches do |t|
      t.integer :pk_home_goal, :default => 0
      t.integer :pk_away_goal, :default => 0
    end
  end
end
