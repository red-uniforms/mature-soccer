class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"

  belongs_to :cup

  validate :home_away_belongs_to_cup, unless: "cup_id.nil?"
  validate :team_different

  validates :home_team_id, presence: true
  validates :away_team_id, presence: true

  validates :description, presence: true, length: { minimum: 2, maximum: 40 }
  validates :date, presence: true
  validates :half, presence: true, numericality: { only_integer: true }
  validates :extra, numericality: { only_integer: true }

  def home_away_belongs_to_cup
    if cup.teams.include? away_team_id and cup.teams.include? home_team_id
    else
      errors.add(:home_team, "team has to participate the cup")
      errors.add(:away_team, "team has to participate the cup")
    end
  end
  def team_different
    if home_team == away_team
      errors.add(:home_team, "home and away team should be different")
      errors.add(:away_team, "home and away team should be different")
    end
  end
  def date_s
    # string representation of date
  end

end
