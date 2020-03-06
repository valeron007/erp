class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def export
    authorize Client

    @filterrific = initialize_filterrific(
        Client,
        params[:filterrific],
    ) or return

    @clients = @filterrific.find

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="dailytimesheets_export.xlsx"'
      }
    end

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="clients_export.xlsx"'
      }
    end
  end

  # GET /clients
  # GET /clients.json
  def index
    authorize Client
    @filterrific = initialize_filterrific(
        Client,
        params[:filterrific],
    ) or return

    #@facilities = @filterrific.find.for_foreman(current_user).page(params[:page])
    @selected_per_page = get_session_per_page(Client.per_page)
    @clients = @filterrific.find.page(params[:page]).per_page(@selected_per_page)
    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    authorize @client
    set_return_to
    @return_to = get_return_to_or_default clients_url
  end

  # GET /clients/new
  def new
    @client = Client.new
    authorize @client
    set_return_to
    @return_to = get_return_to_or_default clients_url
  end

  # GET /clients/1/edit
  def edit
    authorize @client
    set_return_to
    @return_to = get_return_to_or_default clients_url
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    authorize @client
    respond_to do |format|
      if @client.save
        format.html { redirect_back_or_default clients_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @client }
        format.js { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
        format.js { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    authorize @client
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_back_or_default clients_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    authorize @client
    @client.destroy
    respond_to do |format|
      format.html { redirect_back_or_default clients_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(
          :name,
          :address,
          :phone,
          :comment
      )
    end
end
