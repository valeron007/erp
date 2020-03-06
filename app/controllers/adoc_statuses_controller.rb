class AdocStatusesController < ApplicationController
  include AccessHelper

  before_action :set_adoc_status, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /adoc_statuses
  # GET /adoc_statuses.json
  def index
    authorize AdocStatus
    @adoc_statuses = AdocStatus.all
  end

  # GET /adoc_statuses/1
  # GET /adoc_statuses/1.json
  def show
    authorize @adoc_status
  end

  # GET /adoc_statuses/new
  def new
    @adoc_status = AdocStatus.new
    authorize @adoc_status
  end

  # GET /adoc_statuses/1/edit
  def edit
    authorize @adoc_status
  end

  # POST /adoc_statuses
  # POST /adoc_statuses.json
  def create
    @adoc_status = AdocStatus.new(adoc_status_params)
    authorize @adoc_status
    respond_to do |format|
      if @adoc_status.save
        format.html { redirect_to @adoc_status, notice: 'Adoc status was successfully created.' }
        format.json { render :show, status: :created, location: @adoc_status }
      else
        format.html { render :new }
        format.json { render json: @adoc_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adoc_statuses/1
  # PATCH/PUT /adoc_statuses/1.json
  def update
    authorize @adoc_status
    respond_to do |format|
      if @adoc_status.update(adoc_status_params)
        format.html { redirect_to @adoc_status, notice: 'Adoc status was successfully updated.' }
        format.json { render :show, status: :ok, location: @adoc_status }
      else
        format.html { render :edit }
        format.json { render json: @adoc_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adoc_statuses/1
  # DELETE /adoc_statuses/1.json
  def destroy
    authorize @adoc_status
    @adoc_status.destroy
    respond_to do |format|
      format.html { redirect_to adoc_statuses_url, notice: 'Adoc status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adoc_status
      @adoc_status = AdocStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adoc_status_params
      params.require(:adoc_status).permit(:name, :color, :order)
    end
end
