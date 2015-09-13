class Group < ActiveRecord::Base
  belongs_to :cup

  has_many :teams
  has_many :team_rows, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :max_team, presence: true

  def create_rows
    if self.teams.count != self.team_rows.count
      self.teams.each do |t|
        self.team_rows.create(team_id: t.id)
      end
    end
  end

  def matches
    matches = []
    self.teams.each do |t|
      matches += t.home_matches.where(cup_id: self.cup.id, status: "end")
      matches += t.away_matches.where(cup_id: self.cup.id, status: "end")
    end
    matches.uniq
  end

  def reset_rows
    team_rows.each do |t|
      team_row.update(win: 0, lose: 0, draw: 0, goal_difference: 0)
    end
  end

  def update_rows
    self.matches.each do |m|

      home_row = self.team_rows.where(team_id: m.home_team.id).take
      away_row = self.team_rows.where(team_id: m.away_team.id).take

      if m.home_goal > m.away_goal
        
        home_row.update(win: home_row.win+1)
        away_row.update(lose: away_row.lose+1)

      elsif m.home_goal == m.away_goal

        home_row.update(draw: home_row.draw+1)
        away_row.update(draw: away_row.draw+1)

      else

        home_row.update(lose: home_row.lose+1)
        away_row.update(win: away_row.win+1)

      end

      home_row.update(goal_difference: home_row.goal_difference + (m.home_goal-m.away_goal))
      away_row.update(goal_difference: away_row.goal_difference + (m.away_goal-m.home_goal))
          
    end
  end
end
