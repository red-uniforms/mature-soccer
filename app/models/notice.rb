class Notice < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5, maximum: 20 }
end
