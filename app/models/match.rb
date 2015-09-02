class Match < ActiveRecord::Base
  has_one :home_team, class_name: "Team"
  has_one :away_team, class_name: "Team"

  belongs_to :cup

  validate :home_away_belongs_to_cup, unless: "cup.nil?"
  validate :team_different

  validates :home_team, presence: true
  validates :away_team, presence: true
  # home and away teams should be participating in the cup
  validates :description, presence: true, length: { minimum: 2, maximum: 40 }
  validates :date, presence: true
  validates :half, presence: true, numericality: { only_integer: true }
  validates :extra, numericality: { only_integer: true }

  def home_away_belongs_to_cup
    if cup.teams.include? away_team and cup.teams.include? home_team
    else
      errors.add(:home_team, "team has to participating the cup")
      errors.add(:away_team, "team has to participating the cup")
    end
  end
  def team_different
    if home_team == away_team
      errors.add(:home_team, "home and away team should be different")
      errors.add(:away_team, "home and away team should be different")
    end
  end

end
