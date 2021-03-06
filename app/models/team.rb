class Team < ActiveRecord::Base

  after_save do |team|
    team.users_count = team.members.count
  end

  has_and_belongs_to_many :cups
  has_and_belongs_to_many :users
  has_many :user_infos, dependent: :destroy
  has_many :captains, dependent: :destroy
  has_many :team_applicants, dependent: :destroy
  has_many :home_matches, class_name: "Match" ,foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match" ,foreign_key: "away_team_id"
  has_many :team_rows, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :team_url, format: { with: /\A[-a-z0-9_]{3,20}\Z/, message: "only type lowercase alphabet, numbers, _ and -" },
             uniqueness: { message: "another team has the url"},
             exclusion: { in: %w(new edit search join) }

  # validates :gender, inclusion: { in: %w(Male Female), message: "gender should be male or female" }
  # validates :average_age, inclusion: { in: 1..100, message: "age should be within 1 and 100" }
  validates :uniform_description, length: { minimum: 2, maximum: 40 }

  def applicants
    user_infos.where(applying: true)
  end
  def members
    user_infos.where(applying: false)
  end
  def all_users
    user_infos.where(applying: false).map{ |i| i.user } + captains.map{ |c| c.user }
  end
  def url
    if Rails.env.production?
      "http://madforfootball.com/teams/" + team_url
    else
      "http://localhost:3000/teams/" + team_url
    end
  end
  def captain_user
    users.where(id: captain_user_id).first()
  end
end
