class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.belongs_to :cup
      t.datetime :date

      t.timestamps null: false
    end

    add_reference :matches, :home_team, references: :teams
    add_reference :matches, :away_team, references: :teams

  end
end
