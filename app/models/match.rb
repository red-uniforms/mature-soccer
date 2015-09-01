class Match < ActiveRecord::Base
  has_one :home_team, class_name: "Team"
  has_one :away_team, class_name: "Team"

  belongs_to :cup
end
