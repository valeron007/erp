class TaskNote < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  default_scope { order('created_at DESC') }

  after_commit do
    self.task.tap do |task|
      task.update_note_list
      task.save
    end
  end
end
