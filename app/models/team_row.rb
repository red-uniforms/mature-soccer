class TeamRow < ActiveRecord::Base
  belongs_to :group
  belongs_to :team

  def points
    win*3 + draw
  end
end
