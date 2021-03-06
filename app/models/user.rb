class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :teams
  has_and_belongs_to_many :matches
  has_many :user_infos, dependent: :destroy
  has_many :organizers, dependent: :destroy
  has_many :captains, dependent: :destroy
  has_many :events

  validates :name, length: { minimum: 2, maximum: 20 }

  def applicants
    user_infos.where(applying: true)
  end

  def captain_teams
    captains.map{ |cap| cap.team }
  end

  def all_teams
    teams | captain_teams
  end

  def all_cups
    cups = []
    self.all_teams.each do |t|
      cups += t.team_applicants.map{ |t| t.cup }
    end
    self.organizers.each do |o|
      cups << o.cup
    end
    cups.uniq
  end

end
