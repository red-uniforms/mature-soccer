class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :match

  validates :event_type, inclusion: { in: %w(pkgoal pkmiss) }, if: :is_when_pk?
  validates :event_type, presence: true, inclusion: { in: %w(in out) }, if: :is_when_interval?
  validates :event_type, inclusion: { in: %w(owngoal goal ycard rcard in out) }, if: :is_when_num?
  validates :time, numericality: true, if: :is_when_num?
  validates :when, presence: true, exclusion: { in: ["시작 전"] }

  def time_s
    self.when + time.to_s
  end

  def is_when_interval?
    ["하프타임","연장준비"].include? self.when
  end
  def is_when_num?
    ["전반","후반","연장전반","연장후반"].include? self.when
  end
  def is_when_pk?
    self.when == "승부차기"
  end

  def types
    [
      ["골","goal"],
      ["옐로카드","ycard"],
      ["레드카드","rcard"],
      ["교체 in","in"],
      ["교체 out","out"],
      ["자책골","owngoal"],
      ["승부차기 골","pkgoal"],
      ["승부차기 실축","pkmiss"]
    ]
  end
end
