class Group < ActiveRecord::Base
  belongs_to :cups
  has_many :teams

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :max_team, presence: true
end
