class UserInfo < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :phone, format: { with: /\A01\d-\d{3,4}-\d{4}\Z/, message: "type as 010-1234-1234" }, if: :need_phone?
  with_options if: :need_student_code? do |user|
    user.validates :student_code, presence: true
  end
  validates :career, presence: true, length: { minimum: 2, maximum: 20 }, if: :need_career?

  def need_phone?
    team.phone
  end
  def need_student_code?
    team.student_code
  end
  def need_career?
    team.career
  end
end