class TeamApplicant < ActiveRecord::Base
  belongs_to :team
  belongs_to :cup
end
