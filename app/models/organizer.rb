class Organizer < ActiveRecord::Base
  belongs_to :user
  belongs_to :cup
end
