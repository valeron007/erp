# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190705120853) do

  create_table "additionals", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "unit_id",           limit: 4
    t.decimal  "price_per_unit",                precision: 16, scale: 2
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "document_name",     limit: 255
    t.integer  "inventory_type_id", limit: 4
    t.string   "tags",              limit: 255
  end

  add_index "additionals", ["inventory_type_id"], name: "index_additionals_on_inventory_type_id", using: :btree
  add_index "additionals", ["unit_id"], name: "index_additionals_on_unit_id", using: :btree

  create_table "adoc_names", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "adoc_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "color",      limit: 255
    t.integer  "order",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "adocs", force: :cascade do |t|
    t.integer  "adoc_name_id",   limit: 4
    t.string   "number",         limit: 255
    t.date     "date"
    t.boolean  "present"
    t.decimal  "amount",                     precision: 16, scale: 2
    t.integer  "adoc_status_id", limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "facility_id",    limit: 4
    t.string   "name",           limit: 255
    t.integer  "index_number",   limit: 4
  end

  add_index "adocs", ["adoc_name_id"], name: "index_adocs_on_adoc_name_id", using: :btree
  add_index "adocs", ["adoc_status_id"], name: "index_adocs_on_adoc_status_id", using: :btree
  add_index "adocs", ["facility_id"], name: "index_adocs_on_facility_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.string   "data_fingerprint",  limit: 255
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.text     "comment",    limit: 65535
  end

  create_table "commodity_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "position",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contacts_leads", force: :cascade do |t|
    t.integer "lead_id",    limit: 4
    t.integer "contact_id", limit: 4
  end

  add_index "contacts_leads", ["contact_id"], name: "index_contacts_leads_on_contact_id", using: :btree
  add_index "contacts_leads", ["lead_id"], name: "index_contacts_leads_on_lead_id", using: :btree

  create_table "contractors", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "address",          limit: 255
    t.string   "phone",            limit: 255
    t.string   "email",            limit: 255
    t.text     "contacts",         limit: 65535
    t.string   "storage_address",  limit: 255
    t.text     "contractor_files", limit: 65535
  end

  create_table "d_names", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "price",                  precision: 16, scale: 2
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "d_names_additionals", force: :cascade do |t|
    t.integer "d_name_id",     limit: 4
    t.integer "additional_id", limit: 4
  end

  add_index "d_names_additionals", ["additional_id"], name: "index_d_names_additionals_on_additional_id", using: :btree
  add_index "d_names_additionals", ["d_name_id"], name: "index_d_names_additionals_on_d_name_id", using: :btree

  create_table "d_names_materials", force: :cascade do |t|
    t.integer "d_name_id",   limit: 4
    t.integer "material_id", limit: 4
  end

  add_index "d_names_materials", ["d_name_id"], name: "index_d_names_materials_on_d_name_id", using: :btree
  add_index "d_names_materials", ["material_id"], name: "index_d_names_materials_on_material_id", using: :btree

  create_table "d_names_others", force: :cascade do |t|
    t.integer "d_name_id", limit: 4
    t.integer "other_id",  limit: 4
  end

  add_index "d_names_others", ["d_name_id"], name: "index_d_names_others_on_d_name_id", using: :btree
  add_index "d_names_others", ["other_id"], name: "index_d_names_others_on_other_id", using: :btree

  create_table "d_names_tools", force: :cascade do |t|
    t.integer "d_name_id", limit: 4
    t.integer "tool_id",   limit: 4
  end

  add_index "d_names_tools", ["d_name_id"], name: "index_d_names_tools_on_d_name_id", using: :btree
  add_index "d_names_tools", ["tool_id"], name: "index_d_names_tools_on_tool_id", using: :btree

  create_table "daily_timesheet_penalties", force: :cascade do |t|
    t.integer  "daily_timesheet_id", limit: 4
    t.integer  "penalty_id",         limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "employee_id",        limit: 4
  end

  add_index "daily_timesheet_penalties", ["daily_timesheet_id"], name: "index_daily_timesheet_penalties_on_daily_timesheet_id", using: :btree
  add_index "daily_timesheet_penalties", ["employee_id"], name: "index_daily_timesheet_penalties_on_employee_id", using: :btree
  add_index "daily_timesheet_penalties", ["penalty_id"], name: "index_daily_timesheet_penalties_on_penalty_id", using: :btree

  create_table "daily_timesheet_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "color",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "daily_timesheet_work_types", force: :cascade do |t|
    t.integer  "daily_timesheet_id", limit: 4
    t.integer  "work_type_id",       limit: 4
    t.float    "amount",             limit: 24
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "daily_timesheet_work_types", ["daily_timesheet_id"], name: "index_daily_timesheet_work_types_on_daily_timesheet_id", using: :btree
  add_index "daily_timesheet_work_types", ["work_type_id"], name: "index_daily_timesheet_work_types_on_work_type_id", using: :btree

  create_table "daily_timesheets", force: :cascade do |t|
    t.integer  "facility_id",               limit: 4
    t.integer  "employee_id",               limit: 4
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "salary_period_id",          limit: 4
    t.boolean  "rework"
    t.text     "penalty_description",       limit: 65535
    t.boolean  "probation_period"
    t.integer  "payment_type_id",           limit: 4
    t.float    "ratio",                     limit: 24
    t.float    "salary",                    limit: 24
    t.text     "description",               limit: 65535
    t.float    "total_amount",              limit: 24
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "daily_timesheet_status_id", limit: 4
    t.float    "additional_payment_value",  limit: 24
    t.text     "additional_payment_reason", limit: 65535
    t.boolean  "no_work"
  end

  add_index "daily_timesheets", ["daily_timesheet_status_id"], name: "index_daily_timesheets_on_daily_timesheet_status_id", using: :btree
  add_index "daily_timesheets", ["employee_id"], name: "index_daily_timesheets_on_employee_id", using: :btree
  add_index "daily_timesheets", ["facility_id"], name: "index_daily_timesheets_on_facility_id", using: :btree
  add_index "daily_timesheets", ["payment_type_id"], name: "index_daily_timesheets_on_payment_type_id", using: :btree
  add_index "daily_timesheets", ["salary_period_id"], name: "index_daily_timesheets_on_salary_period_id", using: :btree

  create_table "daily_work_kpis", force: :cascade do |t|
    t.integer  "daily_work_id", limit: 4
    t.integer  "kpi_id",        limit: 4
    t.text     "comment",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "hours",         limit: 24
    t.text     "title",         limit: 65535
    t.integer  "task_id",       limit: 4
  end

  add_index "daily_work_kpis", ["daily_work_id"], name: "index_daily_work_kpis_on_daily_work_id", using: :btree
  add_index "daily_work_kpis", ["kpi_id"], name: "index_daily_work_kpis_on_kpi_id", using: :btree
  add_index "daily_work_kpis", ["task_id"], name: "index_daily_work_kpis_on_task_id", using: :btree

  create_table "daily_works", force: :cascade do |t|
    t.date     "date"
    t.integer  "user_id",    limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "daily_works", ["deleted_at"], name: "index_daily_works_on_deleted_at", using: :btree
  add_index "daily_works", ["user_id"], name: "index_daily_works_on_user_id", using: :btree

  create_table "deliveries", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.integer  "count",                      limit: 4
    t.integer  "unit_id",                    limit: 4
    t.integer  "contractor_id",              limit: 4
    t.integer  "transport_company_id",       limit: 4
    t.float    "volume",                     limit: 24
    t.date     "dispatch_date"
    t.date     "arrival_date"
    t.float    "delivery_cost",              limit: 24
    t.float    "delivery_perunit",           limit: 24
    t.integer  "delivery_payment_status_id", limit: 4
    t.integer  "delivery_status_id",         limit: 4
    t.float    "cost",                       limit: 24
    t.float    "total_with_delivery",        limit: 24
    t.boolean  "vat"
    t.integer  "delivery_document_id",       limit: 4
    t.integer  "delivery_letter_id",         limit: 4
    t.integer  "delivery_dest_id",           limit: 4
    t.date     "order_date"
    t.integer  "commodity_type_id",          limit: 4
    t.string   "pack",                       limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "volume_unit_id",             limit: 4
    t.boolean  "delivery_needed"
    t.float    "price_per_unit",             limit: 24
  end

  add_index "deliveries", ["commodity_type_id"], name: "index_deliveries_on_commodity_type_id", using: :btree
  add_index "deliveries", ["contractor_id"], name: "index_deliveries_on_contractor_id", using: :btree
  add_index "deliveries", ["delivery_dest_id"], name: "index_deliveries_on_delivery_dest_id", using: :btree
  add_index "deliveries", ["delivery_document_id"], name: "index_deliveries_on_delivery_document_id", using: :btree
  add_index "deliveries", ["delivery_letter_id"], name: "index_deliveries_on_delivery_letter_id", using: :btree
  add_index "deliveries", ["delivery_payment_status_id"], name: "index_deliveries_on_delivery_payment_status_id", using: :btree
  add_index "deliveries", ["delivery_status_id"], name: "index_deliveries_on_delivery_status_id", using: :btree
  add_index "deliveries", ["transport_company_id"], name: "index_deliveries_on_transport_company_id", using: :btree
  add_index "deliveries", ["unit_id"], name: "index_deliveries_on_unit_id", using: :btree
  add_index "deliveries", ["volume_unit_id"], name: "index_deliveries_on_volume_unit_id", using: :btree

  create_table "delivery_dests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delivery_documents", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delivery_letters", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delivery_notes", force: :cascade do |t|
    t.integer  "delivery_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.text     "val",         limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "delivery_notes", ["delivery_id"], name: "index_delivery_notes_on_delivery_id", using: :btree
  add_index "delivery_notes", ["user_id"], name: "index_delivery_notes_on_user_id", using: :btree

  create_table "delivery_payment_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delivery_statuses", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "order_number", limit: 4
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "content",       limit: 65535
    t.integer  "created_by_id", limit: 4
    t.integer  "updated_by_id", limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "roles",         limit: 255
    t.integer  "document_type", limit: 4,     default: 0
  end

  add_index "documents", ["created_by_id"], name: "index_documents_on_created_by_id", using: :btree
  add_index "documents", ["updated_by_id"], name: "index_documents_on_updated_by_id", using: :btree

  create_table "employee_notes", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.text     "val",         limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "employee_notes", ["employee_id"], name: "index_employee_notes_on_employee_id", using: :btree
  add_index "employee_notes", ["user_id"], name: "index_employee_notes_on_user_id", using: :btree

  create_table "employee_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "order",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name",                         limit: 255
    t.string   "last_name",                          limit: 255
    t.string   "middle_name",                        limit: 255
    t.integer  "position_id",                        limit: 4
    t.date     "hire_date"
    t.integer  "probation_period",                   limit: 4
    t.integer  "employee_status_id",                 limit: 4
    t.date     "fire_date"
    t.integer  "fire_reason_id",                     limit: 4
    t.string   "passport",                           limit: 255
    t.date     "birth_date"
    t.string   "citizenship",                        limit: 255
    t.string   "nationality",                        limit: 255
    t.boolean  "felony"
    t.text     "felony_notes",                       limit: 65535
    t.float    "salary",                             limit: 24
    t.float    "salary_ratio",                       limit: 24
    t.string   "card_number",                        limit: 255
    t.string   "card_owner",                         limit: 255
    t.string   "shoes_size",                         limit: 255
    t.string   "dress_size",                         limit: 255
    t.string   "height",                             limit: 255
    t.integer  "children_count",                     limit: 4
    t.string   "mobile_number",                      limit: 255
    t.string   "phone_number",                       limit: 255
    t.string   "address",                            limit: 255
    t.string   "residential_address",                limit: 255
    t.string   "emergency_name",                     limit: 255
    t.string   "emergency_phone",                    limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "avatar_file_name",                   limit: 255
    t.string   "avatar_content_type",                limit: 255
    t.integer  "avatar_file_size",                   limit: 4
    t.datetime "avatar_updated_at"
    t.string   "passport_front_file_name",           limit: 255
    t.string   "passport_front_content_type",        limit: 255
    t.integer  "passport_front_file_size",           limit: 4
    t.datetime "passport_front_updated_at"
    t.string   "passport_reg_file_name",             limit: 255
    t.string   "passport_reg_content_type",          limit: 255
    t.integer  "passport_reg_file_size",             limit: 4
    t.datetime "passport_reg_updated_at"
    t.string   "additional_document_1_file_name",    limit: 255
    t.string   "additional_document_1_content_type", limit: 255
    t.integer  "additional_document_1_file_size",    limit: 4
    t.datetime "additional_document_1_updated_at"
    t.string   "additional_document_2_file_name",    limit: 255
    t.string   "additional_document_2_content_type", limit: 255
    t.integer  "additional_document_2_file_size",    limit: 4
    t.datetime "additional_document_2_updated_at"
    t.string   "additional_document_3_file_name",    limit: 255
    t.string   "additional_document_3_content_type", limit: 255
    t.integer  "additional_document_3_file_size",    limit: 4
    t.datetime "additional_document_3_updated_at"
    t.string   "additional_card_number",             limit: 255
    t.string   "additional_card_owner",              limit: 255
    t.integer  "user_id",                            limit: 4
  end

  add_index "employees", ["employee_status_id"], name: "index_employees_on_employee_status_id", using: :btree
  add_index "employees", ["fire_reason_id"], name: "index_employees_on_fire_reason_id", using: :btree
  add_index "employees", ["position_id"], name: "index_employees_on_position_id", using: :btree
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "expense_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.decimal  "amount",                          precision: 16, scale: 2
    t.string   "company",             limit: 255
    t.string   "facility",            limit: 255
    t.integer  "expense_category_id", limit: 4
    t.date     "expense_date"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "expense_by_id",       limit: 4
    t.integer  "created_by_id",       limit: 4
    t.integer  "updated_by_id",       limit: 4
    t.integer  "direction",           limit: 4
    t.datetime "deleted_at"
    t.integer  "expense_to_id",       limit: 4
  end

  add_index "expenses", ["created_by_id"], name: "index_expenses_on_created_by_id", using: :btree
  add_index "expenses", ["deleted_at"], name: "index_expenses_on_deleted_at", using: :btree
  add_index "expenses", ["expense_by_id"], name: "index_expenses_on_expense_by_id", using: :btree
  add_index "expenses", ["expense_category_id"], name: "index_expenses_on_expense_category_id", using: :btree
  add_index "expenses", ["expense_to_id"], name: "index_expenses_on_expense_to_id", using: :btree
  add_index "expenses", ["updated_by_id"], name: "index_expenses_on_updated_by_id", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "address",              limit: 255
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "facility_status_id",   limit: 4
    t.datetime "deleted_at"
    t.string   "doer",                 limit: 255
    t.string   "customer",             limit: 255
    t.string   "full_name",            limit: 255
    t.text     "contact_name",         limit: 65535
    t.string   "contract_number",      limit: 255
    t.date     "contract_date"
    t.integer  "foreman_id",           limit: 4
    t.date     "finish_date"
    t.decimal  "p_total",                            precision: 12, scale: 2
    t.decimal  "p_paid",                             precision: 12, scale: 2
    t.decimal  "p_left",                             precision: 12, scale: 2
    t.date     "projected_start_date"
    t.date     "status_change_date"
    t.integer  "lead_id",              limit: 4
    t.integer  "client_id",            limit: 4
  end

  add_index "facilities", ["client_id"], name: "index_facilities_on_client_id", using: :btree
  add_index "facilities", ["deleted_at"], name: "index_facilities_on_deleted_at", using: :btree
  add_index "facilities", ["facility_status_id"], name: "index_facilities_on_facility_status_id", using: :btree
  add_index "facilities", ["foreman_id"], name: "index_facilities_on_foreman_id", using: :btree
  add_index "facilities", ["lead_id"], name: "index_facilities_on_lead_id", using: :btree

  create_table "facility_additionals", force: :cascade do |t|
    t.integer  "facility_id",   limit: 4
    t.integer  "additional_id", limit: 4
    t.float    "amount",        limit: 24
    t.float    "total_price",   limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "facility_additionals", ["additional_id"], name: "index_facility_additionals_on_additional_id", using: :btree
  add_index "facility_additionals", ["facility_id"], name: "index_facility_additionals_on_facility_id", using: :btree

  create_table "facility_costs", force: :cascade do |t|
    t.integer  "facility_id", limit: 4
    t.string   "title",       limit: 255
    t.float    "amount",      limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "facility_costs", ["facility_id"], name: "index_facility_costs_on_facility_id", using: :btree

  create_table "facility_materials", force: :cascade do |t|
    t.integer  "facility_id", limit: 4
    t.integer  "material_id", limit: 4
    t.float    "amount",      limit: 24
    t.float    "total_price", limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "facility_materials", ["facility_id"], name: "index_facility_materials_on_facility_id", using: :btree
  add_index "facility_materials", ["material_id"], name: "index_facility_materials_on_material_id", using: :btree

  create_table "facility_notes", force: :cascade do |t|
    t.integer  "facility_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.text     "val",         limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "facility_notes", ["facility_id"], name: "index_facility_notes_on_facility_id", using: :btree
  add_index "facility_notes", ["user_id"], name: "index_facility_notes_on_user_id", using: :btree

  create_table "facility_others", force: :cascade do |t|
    t.integer  "facility_id", limit: 4
    t.integer  "other_id",    limit: 4
    t.float    "amount",      limit: 24
    t.float    "total_price", limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "facility_others", ["facility_id"], name: "index_facility_others_on_facility_id", using: :btree
  add_index "facility_others", ["other_id"], name: "index_facility_others_on_other_id", using: :btree

  create_table "facility_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "facility_tools", force: :cascade do |t|
    t.integer  "facility_id", limit: 4
    t.integer  "tool_id",     limit: 4
    t.float    "amount",      limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "facility_tools", ["facility_id"], name: "index_facility_tools_on_facility_id", using: :btree
  add_index "facility_tools", ["tool_id"], name: "index_facility_tools_on_tool_id", using: :btree

  create_table "facility_work_types", force: :cascade do |t|
    t.integer  "facility_id",  limit: 4
    t.integer  "work_type_id", limit: 4
    t.float    "amount",       limit: 24
    t.float    "total_price",  limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "facility_work_types", ["facility_id"], name: "index_facility_work_types_on_facility_id", using: :btree
  add_index "facility_work_types", ["work_type_id"], name: "index_facility_work_types_on_work_type_id", using: :btree

  create_table "fire_reasons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "order",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "inventory_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "kpis", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "weight",     limit: 24
    t.float    "norm",       limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "roles",      limit: 255
  end

  create_table "lead_construction_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lead_construction_types_leads", id: false, force: :cascade do |t|
    t.integer "lead_construction_type_id", limit: 4
    t.integer "lead_id",                   limit: 4
  end

  add_index "lead_construction_types_leads", ["lead_construction_type_id"], name: "index_lead_construction_types_leads_on_lead_construction_type_id", using: :btree
  add_index "lead_construction_types_leads", ["lead_id"], name: "index_lead_construction_types_leads_on_lead_id", using: :btree

  create_table "lead_notes", force: :cascade do |t|
    t.integer  "lead_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "val",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "lead_notes", ["lead_id"], name: "index_lead_notes_on_lead_id", using: :btree
  add_index "lead_notes", ["user_id"], name: "index_lead_notes_on_user_id", using: :btree

  create_table "lead_payment_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lead_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lead_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "short_name",             limit: 255
    t.integer  "client_id",              limit: 4
    t.string   "address",                limit: 255
    t.date     "visit_date"
    t.integer  "lead_status_id",         limit: 4
    t.integer  "lead_type_id",           limit: 4
    t.boolean  "project"
    t.string   "project_institute",      limit: 255
    t.string   "gip",                    limit: 255
    t.string   "gip_phone",              limit: 255
    t.string   "gap",                    limit: 255
    t.string   "gap_phone",              limit: 255
    t.boolean  "project_help"
    t.text     "details",                limit: 65535
    t.text     "representatives",        limit: 65535
    t.boolean  "psycho01"
    t.boolean  "psycho02"
    t.boolean  "psycho03"
    t.boolean  "psycho04"
    t.boolean  "psycho05"
    t.boolean  "psycho06"
    t.boolean  "psycho07"
    t.boolean  "psycho08"
    t.boolean  "psycho09"
    t.boolean  "psycho10"
    t.boolean  "psycho11"
    t.boolean  "psycho12"
    t.boolean  "psycho13"
    t.text     "psycho_other",           limit: 65535
    t.decimal  "sum_contract",                         precision: 16, scale: 2
    t.integer  "lead_payment_status_id", limit: 4
    t.decimal  "sum_payment",                          precision: 16, scale: 2
    t.decimal  "debt",                                 precision: 16, scale: 2
    t.string   "credit",                 limit: 255
    t.date     "next_date"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.text     "lead_files",             limit: 65535
    t.integer  "created_by_id",          limit: 4
    t.integer  "updated_by_id",          limit: 4
    t.datetime "deleted_at"
    t.text     "next_visit_comment",     limit: 65535
    t.text     "error_text",             limit: 65535
  end

  add_index "leads", ["client_id"], name: "index_leads_on_client_id", using: :btree
  add_index "leads", ["created_by_id"], name: "index_leads_on_created_by_id", using: :btree
  add_index "leads", ["deleted_at"], name: "index_leads_on_deleted_at", using: :btree
  add_index "leads", ["lead_payment_status_id"], name: "index_leads_on_lead_payment_status_id", using: :btree
  add_index "leads", ["lead_status_id"], name: "index_leads_on_lead_status_id", using: :btree
  add_index "leads", ["lead_type_id"], name: "index_leads_on_lead_type_id", using: :btree
  add_index "leads", ["updated_by_id"], name: "index_leads_on_updated_by_id", using: :btree

  create_table "materials", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "unit_id",           limit: 4
    t.decimal  "price_per_unit",                precision: 16, scale: 2
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "document_name",     limit: 255
    t.integer  "inventory_type_id", limit: 4
    t.string   "tags",              limit: 255
  end

  add_index "materials", ["inventory_type_id"], name: "index_materials_on_inventory_type_id", using: :btree
  add_index "materials", ["unit_id"], name: "index_materials_on_unit_id", using: :btree

  create_table "others", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.integer  "unit_id",           limit: 4
    t.decimal  "price_per_unit",                precision: 16, scale: 2
    t.string   "document_name",     limit: 255
    t.integer  "inventory_type_id", limit: 4
    t.string   "tags",              limit: 255
  end

  add_index "others", ["inventory_type_id"], name: "index_others_on_inventory_type_id", using: :btree
  add_index "others", ["unit_id"], name: "index_others_on_unit_id", using: :btree

  create_table "payment_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "penalties", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.float    "penalty_rate", limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "s_additionals", force: :cascade do |t|
    t.integer  "additional_id",      limit: 4
    t.decimal  "amount",                           precision: 16, scale: 3
    t.integer  "unit_id",            limit: 4
    t.decimal  "min_amount",                       precision: 16, scale: 3
    t.string   "storage_place",      limit: 255
    t.text     "comments",           limit: 65535
    t.text     "s_additional_files", limit: 65535
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  add_index "s_additionals", ["additional_id"], name: "index_s_additionals_on_additional_id", using: :btree
  add_index "s_additionals", ["unit_id"], name: "index_s_additionals_on_unit_id", using: :btree

  create_table "s_materials", force: :cascade do |t|
    t.string   "pack",             limit: 255
    t.decimal  "amount",                         precision: 16, scale: 3
    t.integer  "unit_id",          limit: 4
    t.decimal  "min_amount",                     precision: 16, scale: 3
    t.string   "storage_place",    limit: 255
    t.text     "comments",         limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "name_id",          limit: 4
    t.text     "s_material_files", limit: 65535
  end

  add_index "s_materials", ["name_id"], name: "index_s_materials_on_name_id", using: :btree
  add_index "s_materials", ["unit_id"], name: "index_s_materials_on_unit_id", using: :btree

  create_table "s_others", force: :cascade do |t|
    t.decimal  "amount",                      precision: 16, scale: 3
    t.integer  "unit_id",       limit: 4
    t.decimal  "min_amount",                  precision: 16, scale: 3
    t.string   "storage_place", limit: 255
    t.text     "comments",      limit: 65535
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "name_id",       limit: 4
    t.text     "s_other_files", limit: 65535
  end

  add_index "s_others", ["name_id"], name: "index_s_others_on_name_id", using: :btree
  add_index "s_others", ["unit_id"], name: "index_s_others_on_unit_id", using: :btree

  create_table "s_tools", force: :cascade do |t|
    t.string   "description",      limit: 255
    t.string   "serial_number",    limit: 255
    t.string   "rfid_tag",         limit: 255
    t.string   "barcode_tag",      limit: 255
    t.string   "consist",          limit: 255
    t.float    "min_amount",       limit: 24
    t.string   "storage_place",    limit: 255
    t.string   "state",            limit: 255
    t.text     "comments",         limit: 65535
    t.text     "photos",           limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "name_id",          limit: 4
    t.string   "inventory_number", limit: 255
    t.text     "s_tool_files",     limit: 65535
    t.integer  "facility_id",      limit: 4
    t.boolean  "trashed",                        default: false
  end

  add_index "s_tools", ["facility_id"], name: "index_s_tools_on_facility_id", using: :btree
  add_index "s_tools", ["name_id"], name: "index_s_tools_on_name_id", using: :btree

  create_table "s_transaction_additionals", force: :cascade do |t|
    t.integer  "s_additional_id",  limit: 4
    t.integer  "s_transaction_id", limit: 4
    t.decimal  "s_amount",                   precision: 16, scale: 3
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "s_transaction_additionals", ["s_additional_id"], name: "index_s_transaction_additionals_on_s_additional_id", using: :btree
  add_index "s_transaction_additionals", ["s_transaction_id"], name: "index_s_transaction_additionals_on_s_transaction_id", using: :btree

  create_table "s_transaction_materials", force: :cascade do |t|
    t.integer  "s_material_id",    limit: 4
    t.integer  "s_transaction_id", limit: 4
    t.decimal  "s_amount",                   precision: 16, scale: 3
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "s_transaction_materials", ["s_material_id"], name: "index_s_transaction_materials_on_s_material_id", using: :btree
  add_index "s_transaction_materials", ["s_transaction_id"], name: "index_s_transaction_materials_on_s_transaction_id", using: :btree

  create_table "s_transaction_notes", force: :cascade do |t|
    t.integer  "s_transaction_id", limit: 4
    t.integer  "user_id",          limit: 4
    t.text     "val",              limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "s_transaction_notes", ["s_transaction_id"], name: "index_s_transaction_notes_on_s_transaction_id", using: :btree
  add_index "s_transaction_notes", ["user_id"], name: "index_s_transaction_notes_on_user_id", using: :btree

  create_table "s_transaction_others", force: :cascade do |t|
    t.integer  "s_other_id",       limit: 4
    t.integer  "s_transaction_id", limit: 4
    t.decimal  "s_amount",                   precision: 16, scale: 3
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "s_transaction_others", ["s_other_id"], name: "index_s_transaction_others_on_s_other_id", using: :btree
  add_index "s_transaction_others", ["s_transaction_id"], name: "index_s_transaction_others_on_s_transaction_id", using: :btree

  create_table "s_transaction_tools", force: :cascade do |t|
    t.integer  "s_tool_id",        limit: 4
    t.integer  "s_transaction_id", limit: 4
    t.string   "s_tool_state",     limit: 255
    t.text     "s_comment",        limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "s_transaction_tools", ["s_tool_id"], name: "index_s_transaction_tools_on_s_tool_id", using: :btree
  add_index "s_transaction_tools", ["s_transaction_id"], name: "index_s_transaction_tools_on_s_transaction_id", using: :btree

  create_table "s_transactions", force: :cascade do |t|
    t.date     "date"
    t.text     "comments",        limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "destination_id",  limit: 4
    t.integer  "user_from_id",    limit: 4
    t.integer  "user_to_id",      limit: 4
    t.datetime "deleted_at"
    t.string   "operation_type",  limit: 255
    t.integer  "source_id",       limit: 4
    t.integer  "employee_id",     limit: 4
    t.text     "error_text",      limit: 65535
    t.string   "document_number", limit: 255
    t.integer  "driver_id",       limit: 4
  end

  add_index "s_transactions", ["deleted_at"], name: "index_s_transactions_on_deleted_at", using: :btree
  add_index "s_transactions", ["destination_id"], name: "index_s_transactions_on_destination_id", using: :btree
  add_index "s_transactions", ["driver_id"], name: "index_s_transactions_on_driver_id", using: :btree
  add_index "s_transactions", ["employee_id"], name: "index_s_transactions_on_employee_id", using: :btree
  add_index "s_transactions", ["source_id"], name: "index_s_transactions_on_source_id", using: :btree
  add_index "s_transactions", ["user_from_id"], name: "index_s_transactions_on_user_from_id", using: :btree
  add_index "s_transactions", ["user_to_id"], name: "index_s_transactions_on_user_to_id", using: :btree

  create_table "salary_periods", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "task_notes", force: :cascade do |t|
    t.integer  "task_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "val",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "task_notes", ["task_id"], name: "index_task_notes_on_task_id", using: :btree
  add_index "task_notes", ["user_id"], name: "index_task_notes_on_user_id", using: :btree

  create_table "task_statuses", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "order",      limit: 4
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "desc",           limit: 65535
    t.date     "assign_date"
    t.date     "finish_date"
    t.integer  "task_status_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "assigned_by_id", limit: 4
    t.integer  "assigned_to_id", limit: 4
    t.integer  "created_by_id",  limit: 4
    t.integer  "updated_by_id",  limit: 4
    t.boolean  "regularly"
    t.datetime "done_date"
    t.text     "result",         limit: 65535
    t.text     "files",          limit: 65535
    t.boolean  "important"
    t.boolean  "urgent"
    t.text     "file_list",      limit: 65535
    t.text     "note_list",      limit: 65535
  end

  add_index "tasks", ["assigned_by_id"], name: "index_tasks_on_assigned_by_id", using: :btree
  add_index "tasks", ["assigned_to_id"], name: "index_tasks_on_assigned_to_id", using: :btree
  add_index "tasks", ["created_by_id"], name: "index_tasks_on_created_by_id", using: :btree
  add_index "tasks", ["task_status_id"], name: "index_tasks_on_task_status_id", using: :btree
  add_index "tasks", ["updated_by_id"], name: "index_tasks_on_updated_by_id", using: :btree

  create_table "tools", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "document_name",     limit: 255
    t.integer  "inventory_type_id", limit: 4
    t.decimal  "price_per_unit",                precision: 16, scale: 2
    t.string   "tags",              limit: 255
  end

  add_index "tools", ["inventory_type_id"], name: "index_tools_on_inventory_type_id", using: :btree

  create_table "transport_companies", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "address",                 limit: 255
    t.string   "phone",                   limit: 255
    t.string   "email",                   limit: 255
    t.text     "contacts",                limit: 65535
    t.text     "transport_company_files", limit: 65535
  end

  create_table "units", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.integer  "role",                   limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 191,        null: false
    t.integer  "item_id",        limit: 4,          null: false
    t.string   "event",          limit: 255,        null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object",         limit: 4294967295
    t.datetime "created_at"
    t.text     "object_changes", limit: 65535
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "work_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "work_type_additionals", force: :cascade do |t|
    t.integer  "work_type_id",  limit: 4
    t.integer  "additional_id", limit: 4
    t.float    "amount",        limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "work_type_additionals", ["additional_id"], name: "index_work_type_additionals_on_additional_id", using: :btree
  add_index "work_type_additionals", ["work_type_id"], name: "index_work_type_additionals_on_work_type_id", using: :btree

  create_table "work_type_categories", force: :cascade do |t|
    t.integer  "work_category_id", limit: 4
    t.integer  "work_type_id",     limit: 4
    t.float    "amount",           limit: 24
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "work_type_categories", ["work_category_id"], name: "index_work_type_categories_on_work_category_id", using: :btree
  add_index "work_type_categories", ["work_type_id"], name: "index_work_type_categories_on_work_type_id", using: :btree

  create_table "work_type_materials", force: :cascade do |t|
    t.integer  "work_type_id", limit: 4
    t.integer  "material_id",  limit: 4
    t.float    "amount",       limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "work_type_materials", ["material_id"], name: "index_work_type_materials_on_material_id", using: :btree
  add_index "work_type_materials", ["work_type_id"], name: "index_work_type_materials_on_work_type_id", using: :btree

  create_table "work_type_others", force: :cascade do |t|
    t.integer  "work_type_id", limit: 4
    t.integer  "other_id",     limit: 4
    t.float    "amount",       limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "work_type_others", ["other_id"], name: "index_work_type_others_on_other_id", using: :btree
  add_index "work_type_others", ["work_type_id"], name: "index_work_type_others_on_work_type_id", using: :btree

  create_table "work_type_tools", force: :cascade do |t|
    t.integer  "work_type_id", limit: 4
    t.integer  "tool_id",      limit: 4
    t.float    "amount",       limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "work_type_tools", ["tool_id"], name: "index_work_type_tools_on_tool_id", using: :btree
  add_index "work_type_tools", ["work_type_id"], name: "index_work_type_tools_on_work_type_id", using: :btree

  create_table "work_types", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.float    "price_per_unit", limit: 24
    t.integer  "facility_id",    limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "unit_id",        limit: 4
  end

  add_index "work_types", ["facility_id"], name: "index_work_types_on_facility_id", using: :btree
  add_index "work_types", ["unit_id"], name: "index_work_types_on_unit_id", using: :btree

  add_foreign_key "additionals", "inventory_types"
  add_foreign_key "additionals", "units"
  add_foreign_key "adocs", "adoc_names"
  add_foreign_key "adocs", "adoc_statuses"
  add_foreign_key "adocs", "facilities"
  add_foreign_key "contacts_leads", "contacts"
  add_foreign_key "contacts_leads", "leads"
  add_foreign_key "d_names_additionals", "additionals"
  add_foreign_key "d_names_additionals", "d_names"
  add_foreign_key "d_names_materials", "d_names"
  add_foreign_key "d_names_materials", "materials"
  add_foreign_key "d_names_others", "d_names"
  add_foreign_key "d_names_others", "others"
  add_foreign_key "d_names_tools", "d_names"
  add_foreign_key "d_names_tools", "tools"
  add_foreign_key "daily_timesheet_penalties", "employees"
  add_foreign_key "daily_work_kpis", "daily_works"
  add_foreign_key "daily_work_kpis", "kpis"
  add_foreign_key "daily_work_kpis", "tasks"
  add_foreign_key "daily_works", "users"
  add_foreign_key "deliveries", "commodity_types"
  add_foreign_key "deliveries", "contractors"
  add_foreign_key "deliveries", "delivery_dests"
  add_foreign_key "deliveries", "delivery_documents"
  add_foreign_key "deliveries", "delivery_letters"
  add_foreign_key "deliveries", "delivery_payment_statuses"
  add_foreign_key "deliveries", "delivery_statuses"
  add_foreign_key "deliveries", "transport_companies"
  add_foreign_key "deliveries", "units"
  add_foreign_key "deliveries", "units", column: "volume_unit_id"
  add_foreign_key "delivery_notes", "deliveries"
  add_foreign_key "delivery_notes", "users"
  add_foreign_key "documents", "users", column: "created_by_id"
  add_foreign_key "documents", "users", column: "updated_by_id"
  add_foreign_key "employee_notes", "employees"
  add_foreign_key "employee_notes", "users"
  add_foreign_key "employees", "users"
  add_foreign_key "expenses", "expense_categories"
  add_foreign_key "expenses", "users", column: "created_by_id"
  add_foreign_key "expenses", "users", column: "expense_by_id"
  add_foreign_key "expenses", "users", column: "expense_to_id"
  add_foreign_key "expenses", "users", column: "updated_by_id"
  add_foreign_key "facilities", "clients"
  add_foreign_key "facilities", "facility_statuses"
  add_foreign_key "facilities", "leads"
  add_foreign_key "facilities", "users", column: "foreman_id"
  add_foreign_key "facility_additionals", "additionals"
  add_foreign_key "facility_additionals", "facilities"
  add_foreign_key "facility_costs", "facilities"
  add_foreign_key "facility_materials", "facilities"
  add_foreign_key "facility_materials", "materials"
  add_foreign_key "facility_notes", "facilities"
  add_foreign_key "facility_notes", "users"
  add_foreign_key "facility_others", "facilities"
  add_foreign_key "facility_others", "others"
  add_foreign_key "facility_tools", "facilities"
  add_foreign_key "facility_tools", "tools"
  add_foreign_key "facility_work_types", "facilities"
  add_foreign_key "facility_work_types", "work_types"
  add_foreign_key "lead_notes", "leads"
  add_foreign_key "lead_notes", "users"
  add_foreign_key "leads", "clients"
  add_foreign_key "leads", "lead_payment_statuses"
  add_foreign_key "leads", "lead_statuses"
  add_foreign_key "leads", "lead_types"
  add_foreign_key "leads", "users", column: "created_by_id"
  add_foreign_key "leads", "users", column: "updated_by_id"
  add_foreign_key "materials", "inventory_types"
  add_foreign_key "materials", "units"
  add_foreign_key "others", "inventory_types"
  add_foreign_key "others", "units"
  add_foreign_key "s_additionals", "additionals"
  add_foreign_key "s_additionals", "units"
  add_foreign_key "s_materials", "materials", column: "name_id"
  add_foreign_key "s_materials", "units"
  add_foreign_key "s_others", "others", column: "name_id"
  add_foreign_key "s_others", "units"
  add_foreign_key "s_tools", "facilities"
  add_foreign_key "s_tools", "tools", column: "name_id"
  add_foreign_key "s_transaction_additionals", "s_additionals"
  add_foreign_key "s_transaction_additionals", "s_transactions"
  add_foreign_key "s_transaction_materials", "s_materials"
  add_foreign_key "s_transaction_materials", "s_transactions"
  add_foreign_key "s_transaction_notes", "s_transactions"
  add_foreign_key "s_transaction_notes", "users"
  add_foreign_key "s_transaction_others", "s_others"
  add_foreign_key "s_transaction_others", "s_transactions"
  add_foreign_key "s_transaction_tools", "s_tools"
  add_foreign_key "s_transaction_tools", "s_transactions"
  add_foreign_key "s_transactions", "employees"
  add_foreign_key "s_transactions", "employees", column: "user_from_id"
  add_foreign_key "s_transactions", "employees", column: "user_to_id"
  add_foreign_key "s_transactions", "facilities", column: "destination_id"
  add_foreign_key "s_transactions", "facilities", column: "source_id"
  add_foreign_key "s_transactions", "users", column: "driver_id"
  add_foreign_key "task_notes", "tasks"
  add_foreign_key "task_notes", "users"
  add_foreign_key "tasks", "task_statuses", on_update: :cascade, on_delete: :nullify
  add_foreign_key "tasks", "users", column: "assigned_by_id"
  add_foreign_key "tasks", "users", column: "assigned_to_id"
  add_foreign_key "tasks", "users", column: "created_by_id"
  add_foreign_key "tasks", "users", column: "updated_by_id"
  add_foreign_key "tools", "inventory_types"
  add_foreign_key "work_type_additionals", "additionals"
  add_foreign_key "work_type_additionals", "work_types"
  add_foreign_key "work_type_categories", "work_categories"
  add_foreign_key "work_type_categories", "work_types"
  add_foreign_key "work_type_materials", "materials"
  add_foreign_key "work_type_materials", "work_types"
  add_foreign_key "work_type_others", "others"
  add_foreign_key "work_type_others", "work_types"
  add_foreign_key "work_type_tools", "tools"
  add_foreign_key "work_type_tools", "work_types"
  add_foreign_key "work_types", "units"
end
