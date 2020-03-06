class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :details, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /deliveries
  # GET /deliveries.json
  def index
    # byebug
    authorize Delivery
    @filterrific = initialize_filterrific(
        Delivery,
        params[:filterrific],
        select_options: {
            with_delivery_status_id: DeliveryStatus.options_for_select,
            with_contractor_id: Contractor.options_for_select
        }
    ) or return

    @selected_per_page = get_session_per_page(Delivery.per_page)
    if @filterrific.with_delivery_status_id.nil?
      @deliveries = @filterrific.find.not_finished_deliveries.page(params[:page]).per_page(@selected_per_page)
    else
      @deliveries = @filterrific.find.page(params[:page]).per_page(@selected_per_page)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show
    authorize @delivery
    @delivery_note = DeliveryNote.new(delivery: @delivery)
    set_return_to
    @return_to = get_return_to_or_default deliveries_url
  end

  def details
    authorize @delivery
    respond_to do |format|
      format.js if request.xhr?
      format.html { render :nothing => true, :status => 406 }
    end
  end

  def autocomplete_name
    authorize Delivery
    render json: Delivery.autocomplete_name(params[:name])
  end

  # GET /deliveries/new
  def new
    @delivery = Delivery.new
    authorize @delivery
    set_return_to
    @return_to = get_return_to_or_default deliveries_url
  end

  # GET /deliveries/1/edit
  def edit
    authorize @delivery
    set_return_to
    @return_to = get_return_to_or_default deliveries_url
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
    @delivery = Delivery.new(delivery_params)
    authorize @delivery
    respond_to do |format|
      if @delivery.save
        format.html { redirect_back_or_default deliveries_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @delivery }
      else
        format.html { render :new }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update
    authorize @delivery
    respond_to do |format|
      if @delivery.update(delivery_params)
        format.html { redirect_back_or_default deliveries_url, t('Record has been saved')  }
        format.json { render :show, status: :ok, location: @delivery }
      else
        format.html { render :edit }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    authorize @delivery
    set_return_to
    @delivery.destroy
    respond_to do |format|
      format.html { redirect_back_or_default deliveries_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  def destroy_note
    @delivery_note = DeliveryNote.find_by_id(params[:id])
    @delivery = @delivery_note.delivery
    authorize @delivery
    @delivery_note.destroy

    respond_to do |format|
      format.html { redirect_to delivery_url(@delivery), notice: t('Note removed') }
      format.json { head :no_content }
    end
  end

  def create_note
    @delivery_note = DeliveryNote.new(delivery_note_params)
    @delivery = @delivery_note.delivery
    authorize @delivery
    @delivery_note.user = current_user

    respond_to do |format|
      if @delivery_note.save
        format.html { redirect_to delivery_url(@delivery), notice: t('Note added') }
        format.json { render :show, status: :created, location: @delivery_note.delivery }
      else
        format.html { render :show }
        format.json { render json: @delivery_note.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_params
      params.require(:delivery).permit(:name, :count, :unit_id, :contractor_id, :delivery_needed, :transport_company_id, :volume, :volume_unit_id, :dispatch_date, :arrival_date, :delivery_cost, :delivery_perunit, :delivery_payment_status_id, :delivery_status_id, :cost, :price_per_unit, :total_with_delivery, :vat, :delivery_document_id, :delivery_letter_id, :delivery_dest_id, :order_date, :commodity_type_id, :pack)
    end

    def delivery_note_params
      params.require(:delivery_note).permit(:delivery_id, :val, :updated_by)
    end
end
