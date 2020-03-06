class ContractorsController < ApplicationController
  before_action :set_contractor, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /contractors
  # GET /contractors.json
  def index
    authorize Contractor
    @filterrific = initialize_filterrific(
        Contractor,
        params[:filterrific],
        select_options: {
        }
    ) or return

    @contractors = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /contractors/1
  # GET /contractors/1.json
  def show
    authorize @contractor
    @selected_per_page = get_session_per_page(Delivery.per_page)
    @deliveries = @contractor.deliveries.order(created_at: :desc).page(params[:page]).per_page(@selected_per_page)
  end

  # GET /contractors/new
  def new
    @contractor = Contractor.new
    authorize @contractor
  end

  # GET /contractors/1/edit
  def edit
    authorize @contractor
  end

  # POST /contractors
  # POST /contractors.json
  def create
    @contractor = Contractor.new(contractor_params)
    authorize @contractor
    respond_to do |format|
      if @contractor.save
        format.html { redirect_to @contractor, notice: 'Contractor was successfully created.' }
        format.json { render :show, status: :created, location: @contractor }
      else
        format.html { render :new }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contractors/1
  # PATCH/PUT /contractors/1.json
  def update
    authorize @contractor
    files = @contractor.contractor_files
    files += contractor_params[:contractor_files] if contractor_params[:contractor_files]
    @contractor.assign_attributes(contractor_params)
    @contractor.contractor_files = files

    if params[:contractor_files_remove]

      remain_files = @contractor.contractor_files

      params[:contractor_files_remove].reverse_each do |file, state|
        if state.to_i == 1
          deleted_files = remain_files.delete_at(file.to_i)
          deleted_files.try(:remove!)
        end
      end

      @contractor.remove_contractor_files! if remain_files.empty?

    end
    respond_to do |format|
      if @contractor.save
        format.html { redirect_to @contractor, notice: 'Contractor was successfully updated.' }
        format.json { render :show, status: :ok, location: @contractor }
      else
        format.html { render :edit }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contractors/1
  # DELETE /contractors/1.json
  def destroy
    @contractor.destroy
    respond_to do |format|
      format.html { redirect_to contractors_url, notice: 'Contractor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contractor
      @contractor = Contractor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contractor_params
      params.require(:contractor).permit(:name, :address, :phone, :email, :contacts, :storage_address, :deliverie, {contractor_files: []})
end
end
