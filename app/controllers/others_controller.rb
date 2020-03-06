class OthersController < ApplicationController
  before_action :set_other, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /others
  # GET /others.json
  def index
    @others = if params[:name].present?
      Other.search(params[:name])
    else
      Other.all
    end
    authorize Other
  end

  # GET /others/1
  # GET /others/1.json
  def show
    authorize @other
  end

  # GET /others/new
  def new
    @other = Other.new
    @other.d_names.build if @other.d_names.blank?
    authorize @other
  end

  # GET /others/1/edit
  def edit
    authorize @other
    @other.d_names.build if @other.d_names.blank?
  end

  # POST /others
  # POST /others.json
  def create
    @other = Other.new(other_params)
    authorize @other

    respond_to do |format|
      if @other.save
        format.html { redirect_to others_url, notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @other }
      else
        format.html {
          @other.d_names.build if @other.d_names.blank?
          render :new
        }
        format.json { render json: @other.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /others/1
  # PATCH/PUT /others/1.json
  def update
    authorize @other
    respond_to do |format|
      if @other.update(other_params)
        format.html { redirect_to others_url, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @other }
      else
        format.html {
          @other.d_names.build if @other.d_names.blank?
          render :edit
        }
        format.json { render json: @other.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /others/1
  # DELETE /others/1.json
  def destroy
    authorize @other
    @other.destroy
    respond_to do |format|
      format.html { redirect_to others_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_other
      @other = Other.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def other_params
      params.require(:other).permit(
          :name,
          {tags: []},
          :unit_id,
          :price_per_unit,
          :inventory_type_id,
          d_names_attributes: [:id, :name, :price, :_destroy],
      )
    end
end
