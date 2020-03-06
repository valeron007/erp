class CreateLeadPaymentStatuses < ActiveRecord::Migration
  def change
    create_table :lead_payment_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
