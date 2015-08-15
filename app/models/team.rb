class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :captain_user_id, presence: true, numericality: { only_integer: true }
  validates :team_url, format: { with: /[-a-z0-9_]+/, message: "only type lowercase alphabet, numbers, _ and -" },
             uniqueness: { message: "another team has the url"}, length: { minimum: 4, maximum: 20 },
             exclusion: { in: %w(new edit search) }

  validates :gender, inclusion: { in: %w(Male Female), message: "gender should be male or female" }
  validates :average_age, inclusion: { in: 1..100, message: "age should be within 1 and 100" }
end