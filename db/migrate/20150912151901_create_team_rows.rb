class CreateTeamRows < ActiveRecord::Migration
  def change
    create_table :team_rows do |t|
      t.belongs_to :team
      t.belongs_to :group

      t.integer :win, :default => 0
      t.integer :lose, :default => 0
      t.integer :draw, :default => 0

      t.integer :goal_difference, :default => 0

      t.timestamps null: false
    end

    change_table :matches do |t|
      t.boolean :group_stage, :default => true
    end
  end
end
