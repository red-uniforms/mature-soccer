class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :match

  validates :event_type, presence: true, inclusion: { in: %w(goal ycard rcard in out) }
  validates :time, numericality: true, if: :is_when_num?
  validates :when, presence: true

  def time_s
    self.when + time.to_s
  end

  def is_sub?
    %w(in out).include? event_type
  end

  def is_when_num?
    ["0","1","2","3","4"].include? self.when
  end

  def types
    [
      ["골","goal"],
      ["옐로카드","ycard"],
      ["레드카드","rcard"],
      ["교체 in","in"],
      ["교체 out","out"]
    ]
  end
end
