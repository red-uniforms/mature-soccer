class TeamRow < ActiveRecord::Base
  belongs_to :group
  belongs_to :team
end
