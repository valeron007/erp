class AddAdditionalPaymentToDailyTimesheet < ActiveRecord::Migration
  def change
    add_column :daily_timesheets, :additional_payment_value, :float
    add_column :daily_timesheets, :additional_payment_reason, :text
  end
end
