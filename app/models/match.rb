class Match < ActiveRecord::Base

  before_save do |match|
    if match.extra == 0 and match.statuses.index(match.status) > 3
      match.status = "end"
    end
    match.events.each do |e|
      if e.user.all_teams.include? match.home_team and e.event_type == "goal"
        match.home_goal += 1
      elsif e.user.all_teams.include? match.away_team and e.event_type == "goal"
        match.away_goal += 1
      end
    end
  end

  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"

  belongs_to :cup

  has_many :referees
  has_many :events
  has_and_belongs_to_many :users

  validate :home_away_belongs_to_cup, unless: "cup_id.nil?"
  validate :team_different

  validates :home_team_id, presence: true
  validates :away_team_id, presence: true

  validates :description, presence: true, length: { minimum: 2, maximum: 40 }
  validates :date, presence: true
  validates :half, presence: true, numericality: { only_integer: true }
  validates :tzinfo, presence: true, numericality: { only_integer: true }
  validates :extra, numericality: { only_integer: true }

  validates :status, inclusion: { in: %w(0 1 half 2 interval 3 extrahalf 4 pk end) }

  def started?
    status != "0"
  end
  def ended?
    status == "end"
  end
  def statuses
    %w(0 1 half 2 interval 3 extrahalf 4 pk end)
  end
  def status_s
    ["시작 전","전반","하프타임","후반","연장준비","연장전반","하프타임","연장후반","승부차기",":"]
  end


  def home_away_belongs_to_cup
    if cup.teams.include? away_team and cup.teams.include? home_team
    else
      errors.add(:home_team, "team has to participate the cup")
      errors.add(:away_team, "team has to participate the cup")
    end
  end
  def team_different
    if home_team == away_team
      errors.add(:home_team, "home and away team should be different")
      errors.add(:away_team, "home and away team should be different")
    end
  end
  def date_with_tz
    date + tzinfo.seconds
  end
  def date_s
    # string representation of date
    d = date_with_tz
    d.month.to_s + "월 " + d.day.to_s + "일"
  end
  def wday
    ["월","화","수","목","금","토","일"][date_with_tz.wday]
  end

end
