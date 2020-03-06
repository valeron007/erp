Rails.application.routes.draw do
  resources :contacts
  resources :inventory_types
  resources :s_additionals
  resources :additionals
  get 'daily_works/export'
  resources :daily_works
  resources :kpis
  resources :s_transactions
  resources :s_others
  resources :others
  get 's_tools/update_locations'
  get 's_tools/:id/get_current_location', to: 's_tools#get_current_location'
  resources :s_tools
  resources :s_materials
  get 'deliveries/autocomplete_name'
  resources :deliveries
  resources :delivery_letters
  resources :transport_companies
  resources :contractors
  resources :work_categories
  resources :materials
  resources :tools
  resources :units
  resources :adoc_statuses
  resources :adoc_names
  get 'expenses/export'
  resources :expenses

  resources :tasks
  post 'tasks/destroy_note'
  post 'tasks/create_note'
  post 'tasks/:id/close', to: 'tasks#close', as: :task_close
  post 'tasks/:id/open', to: 'tasks#open', as: :task_open
  get '/tasks/:id/history', to: 'tasks#history', as: :task_history

  mount Ckeditor::Engine => '/ckeditor'
  get '/documents/:id/history', to: 'documents#history', as: :document_history
  resources :documents
  get 'clients/export'
  resources :clients
  resources :leads
  get 'report/dashboard'

  get 'report/employee_payments'
  post 'report/employee_payments'

  get 'report/facility_works'
  post 'report/facility_works'

  get 'report/labor_costs'
  post 'report/labor_costs'

  get 'report/work_efficiency'
  post 'report/work_efficiency'

  get 'report/daily_summary'
  post 'report/daily_summary'

  get 'report/calc'

  get 'employees/export'
  get 'employees/search'

  get 'daily_timesheets/export'

  get 'phone_search', to: "phone_search#search"

  resources :daily_timesheets
  resources :work_types
  resources :penalties
  resources :facilities
  resources :employees
  resources :positions
  patch 'employees/:id/upload_image' => 'employees#upload_image'
  patch 'employees/:id/crop_image' => 'employees#crop_image'
  post 'employees/create_note'
  post 'employees/destroy_note'
  post 'leads/destroy_note'
  post 'leads/create_note'
  patch 'leads/:id/create_error' => 'leads#create_error', as: :lead_create_error
  post 'facilities/destroy_note'
  post 'facilities/create_note'
  post 'deliveries/destroy_note'
  post 'deliveries/create_note'
  post 's_transactions/destroy_note'
  post 's_transactions/create_note'
  get 's_transactions/:id/details', to: 's_transactions#details', as: :s_transactions_details
  patch 's_transactions/:id/create_error' => 's_transactions#create_error', as: :s_transactions_create_error

  get 'deliveries/:id/details', to: 'deliveries#details', as: :deliveries_details


  get 'dashboard' => 'dashboard#index'
  get 'callrecords' => 'call_records#index'

  root to: redirect('/dashboard')
  get 'users/sign_up' => redirect('/404.html')
  post 'users/sign_up' => redirect('/404.html')
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :users
end
