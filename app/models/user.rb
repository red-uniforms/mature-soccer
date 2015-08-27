class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :teams
  has_many :applicants, dependent: :destroy
  has_many :user_infos, dependent: :destroy
  has_many :organizers, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }

  def name
    last_name + " " + first_name
  end

  def applicants
    user_infos.where(applying: true)
  end

end
