class TaskStatus < ActiveRecord::Base

  ASSIGNED = 1
  INPROGRESS = 2
  FINISHED = 3
  IMPORTANT = 4
  URGENT = 5

  def get_badge_color
    case self.id
      when ASSIGNED
        result = "bg-aqua"
      when INPROGRESS
        result = "bg-yellow"
      when IMPORTANT
        result = "bg-red"
      when URGENT
        result = "bg-red"
      when FINISHED
        result = "bg-green"
    end
    result
  end

  def self.assigned_id
    ASSIGNED
  end
  def self.progress_id
    INPROGRESS
  end
  def self.finished_id
    FINISHED
  end

  def is_finished?
    self.id == FINISHED
  end

  def self.options_for_select
    where(id: 1..3).order('`order`').map { |e| [e.title, e.id] }
  end

  def to_s
    title
  end

  def to_label
    to_s
  end
end
