class Referee < ApplicationRecord
  belongs_to :match
  belongs_to :organizer
end
