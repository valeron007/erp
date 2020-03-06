class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @employees = Employee.upcoming_dob.all
    @leads = Lead.for_user(current_user).upcoming_visit.all
    @tasks = Task.assigned_to(current_user).not_closed.upcoming_tasks.order("important desc").order("urgent desc").order('finish_date asc').all
    @deliveries = Delivery.not_finished_deliveries.order('arrival_date ASC').all
    @s_materials = SMaterial.required_order.order('amount ASC').all
    @s_others = SOther.required_order.order('amount ASC').all
    @s_additionals = SAdditional.required_order.order('amount ASC').all
  end
end
