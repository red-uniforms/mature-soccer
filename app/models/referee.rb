class Referee < ActiveRecord::Base
  belongs_to :match
  belongs_to :organizer
end
