module TasksHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::SanitizeHelper

  def format_task_changes(changeset)
    changeset.map do |change, values|
      case change
      when "task_status_id"
        [change.gsub(/_id$/, ""), [TaskStatus.find_by_id(values.first), TaskStatus.find(values.last)]]
      when "assigned_by_id", "assigned_to_id", "created_by_id", "updated_by_id"
        [change.gsub(/_id$/, ""), [User.find_by_id(values.first), User.find(values.last)]]
      when "urgent", "important"
        [change, values.map { |v| I18n.t(v) }]
      when "result"
        [change, values.map { |v| strip_tags(v) }]
      else
        [change, values]
      end
    end.to_h
  end
end
