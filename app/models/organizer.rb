class Organizer < ApplicationRecord
  belongs_to :user
  belongs_to :cup

  has_many :referees
end
