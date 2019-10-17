class TeamApplicant < ApplicationRecord
  belongs_to :team
  belongs_to :cup
end
