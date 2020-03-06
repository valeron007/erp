class AdditionalsController < ApplicationController
  before_action :set_additional, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /additionals
  # GET /additionals.json
  def index
    @additionals = if params[:name].present?
      Additional.search(params[:name])
    else
      Additional.all
    end
    authorize Additional
  end

  # GET /additionals/1
  # GET /additionals/1.json
  def show
    authorize @additional
  end

  # GET /additionals/new
  def new
    @additional = Additional.new
    @additional.d_names.build if @additional.d_names.blank?
    authorize @additional
  end

  # GET /additionals/1/edit
  def edit
    authorize @additional
    @additional.d_names.build if @additional.d_names.blank?
  end

  # POST /additionals
  # POST /additionals.json
  def create
    @additional = Additional.new(additional_params)
    authorize @additional

    respond_to do |format|
      if @additional.save
        format.html { redirect_to additionals_url notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @additional }
      else
        format.html {
          @additional.d_names.build if @additional.d_names.blank?
          render :new
        }
        format.json { render json: @additional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /additionals/1
  # PATCH/PUT /additionals/1.json
  def update
    authorize @additional
    respond_to do |format|
      if @additional.update(additional_params)
        format.html { redirect_to additionals_url, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @additional }
      else
        format.html {
          @additional.d_names.build if @additional.d_names.blank?
          render :edit
        }
        format.json { render json: @additional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /additionals/1
  # DELETE /additionals/1.json
  def destroy
    authorize @additional
    @additional.destroy
    respond_to do |format|
      format.html { redirect_to additionals_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_additional
      @additional = Additional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def additional_params
      params.require(:additional).permit(
          :name,
          {tags: []},
          :unit_id,
          :price_per_unit,
          :inventory_type_id,
          d_names_attributes: [:id, :name, :price, :_destroy],
      )
    end
end
