class Notice < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 20 }
end
