class AddNextVisitCommentToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :next_visit_comment, :text
  end
end
