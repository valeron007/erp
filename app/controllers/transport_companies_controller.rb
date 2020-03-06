class TransportCompaniesController < ApplicationController
  before_action :set_transport_company, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /transport_companies
  # GET /transport_companies.json
  def index
    authorize TransportCompany
    @filterrific = initialize_filterrific(
        TransportCompany,
        params[:filterrific],
        select_options: {
        }
    ) or return

    @transport_companies = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /transport_companies/1
  # GET /transport_companies/1.json
  def show
    authorize @transport_company
    @selected_per_page = get_session_per_page(Delivery.per_page)
    @deliveries = @transport_company.deliveries.order(created_at: :desc).page(params[:page]).per_page(@selected_per_page)
  end

  # GET /transport_companies/new
  def new
    @transport_company = TransportCompany.new
    authorize @transport_company
  end

  # GET /transport_companies/1/edit
  def edit
    authorize @transport_company
  end

  # POST /transport_companies
  # POST /transport_companies.json
  def create
    @transport_company = TransportCompany.new(transport_company_params)
    authorize @transport_company

    respond_to do |format|
      if @transport_company.save
        format.html { redirect_to @transport_company, notice: 'Transport company was successfully created.' }
        format.json { render :show, status: :created, location: @transport_company }
      else
        format.html { render :new }
        format.json { render json: @transport_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transport_companies/1
  # PATCH/PUT /transport_companies/1.json
  def update
    authorize @transport_company
    files = @transport_company.transport_company_files
    files += transport_company_params[:transport_company_files] if transport_company_params[:transport_company_files]
    @transport_company.assign_attributes(transport_company_params)
    @transport_company.transport_company_files = files

    if params[:transport_company_files_remove]
      remain_files = @transport_company.transport_company_files
      params[:transport_company_files_remove].reverse_each do |file, state|
        if state.to_i == 1
          deleted_files = remain_files.delete_at(file.to_i)
          deleted_files.try(:remove!)
        end
      end
      @transport_company.remove_transport_company_files! if remain_files.empty?
    end
    respond_to do |format|
      if @transport_company.save
        format.html { redirect_to @transport_company, notice: 'Transport company was successfully updated.' }
        format.json { render :show, status: :ok, location: @transport_company }
      else
        format.html { render :edit }
        format.json { render json: @transport_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport_companies/1
  # DELETE /transport_companies/1.json
  def destroy
    @transport_company.destroy
    respond_to do |format|
      format.html { redirect_to transport_companies_url, notice: 'Transport company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_company
      @transport_company = TransportCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transport_company_params
      params.require(:transport_company).permit(:name, :address, :phone, :email, :contacts, {transport_company_files: []})
    end
end
