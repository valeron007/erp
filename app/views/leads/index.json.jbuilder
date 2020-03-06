json.array!(@leads) do |lead|
  json.extract! lead, :id, :name, :short_name, :client_id, :address, :visit_date, :lead_status_id, :lead_type_id, :lead_construction_type_id, :project, :project_institute, :gip, :gip_phone, :gap, :gap_phone, :project_help, :details, :representatives, :psycho01, :psycho02, :psycho03, :psycho04, :psycho05, :psycho06, :psycho07, :psycho08, :psycho09, :psycho10, :psycho11, :psycho12, :psycho13, :psycho_other, :sum_contract, :lead_payment_status_id, :sum_payment, :debt, :credit, :next_date
  json.url lead_url(lead, format: :json)
end
