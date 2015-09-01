class Match < ActiveRecord::Base
  has_one :home_team, class_name: "Team"
  has_one :away_team, class_name: "Team"

  belongs_to :cup

  validates :home_team, presence: true
  validates :away_team, presence: true
  # home and away teams should be participating in the cup
  validates :description, presence: true, length: { minimum: 2, maximum: 40 }
  validates :date, presence: true

end
