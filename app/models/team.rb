class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :user_infos, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :captain_user_id, presence: true, numericality: { only_integer: true }
  validates :team_url, format: { with: /\A[-a-z0-9_]{3,20}\Z/, message: "only type lowercase alphabet, numbers, _ and -" },
             uniqueness: { message: "another team has the url"},
             exclusion: { in: %w(new edit search) }

  validates :gender, inclusion: { in: %w(Male Female), message: "gender should be male or female" }
  validates :average_age, inclusion: { in: 1..100, message: "age should be within 1 and 100" }
  validates :uniform_description, length: { minimum: 2, maximum: 40 }

  def applicants
    user_infos.where(applying: true)
  end
end
