class KpisController < ApplicationController
  include AccessHelper

  before_action :set_kpi, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /kpis
  # GET /kpis.json
  def index
    authorize Kpi
    @kpis = Kpi.all
  end

  # GET /kpis/1
  # GET /kpis/1.json
  def show
    authorize @kpi
  end

  # GET /kpis/new
  def new
    @kpi = Kpi.new
    authorize @kpi
  end

  # GET /kpis/1/edit
  def edit
    authorize @kpi
  end

  # POST /kpis
  # POST /kpis.json
  def create
    @kpi = Kpi.new(kpi_params)
    authorize @kpi

    respond_to do |format|
      if @kpi.save
        format.html { redirect_to kpis_url, notice: 'Kpi was successfully created.' }
        format.json { render :show, status: :created, location: @kpi }
      else
        format.html { render :new }
        format.json { render json: @kpi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kpis/1
  # PATCH/PUT /kpis/1.json
  def update
    authorize @kpi
    respond_to do |format|
      if @kpi.update(kpi_params)
        format.html { redirect_to kpis_url, notice: 'Kpi was successfully updated.' }
        format.json { render :show, status: :ok, location: @kpi }
      else
        format.html { render :edit }
        format.json { render json: @kpi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kpis/1
  # DELETE /kpis/1.json
  def destroy
    authorize @kpi
    @kpi.destroy
    respond_to do |format|
      format.html { redirect_to kpis_url, notice: 'Kpi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kpi
      @kpi = Kpi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kpi_params
      params.require(:kpi).permit(
          :name,
          :weight,
          :norm,
          roles: []
      )
    end
end
