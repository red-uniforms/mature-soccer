class Cup < ActiveRecord::Base

  has_many :organizers, dependent: :destroy
  has_many :team_applicants, dependent: :destroy
  has_many :matches
  has_many :notices
  has_many :groups

  has_and_belongs_to_many :teams

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :cup_url, format: { with: /\A[-a-z0-9_]{3,20}\Z/, message: "only type lowercase alphabet, numbers, _ and -" },
             uniqueness: { message: "another cup has the url"},
             exclusion: { in: %w(new edit search join) }
  validates :max_team, numericality: { only_integer: true },
            inclusion: { in: 4..64, message: "team number should be within 4 and 64" }
  validates :description, length: { minimum: 2, maximum: 40 }

  def team_count
    team_applicants.where(applying: false).count
  end
  def teams
    team_applicants.where(applying: false).map{ |ta| ta.team }
  end
  def applying_teams
    team_applicants.where(applying: true).map{ |ta| ta.team }
  end
  def competiton_str
    arr = []
    if has_league
      arr << '조별예선'
    end
    if has_tournament
      arr << '토너먼트'
    end
    arr.join(" + ")
  end
  def url
    if Rails.env.production?
      "http://madforfootball.com/cups/" + cup_url
    else
      "http://amaccer.herokuapp.com/cups/" + cup_url
    end
  end

end
