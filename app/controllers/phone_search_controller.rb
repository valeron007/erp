class PhoneSearchController < ApplicationController
  def search
    authorize Employee, :search?
    authorize Contractor, :can_index?
    authorize Client, :can_index?
    
    if params[:phone].present?
      @employees   = Employee.search_by_phone(params[:phone])
      @contractors = Contractor.search_by_phone(params[:phone])
      @clients     = Client.search_by_phone(params[:phone])
    end
    render :index
  end
end
