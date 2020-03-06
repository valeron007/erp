class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /materials
  # GET /materials.json
  def index
    @materials = if params[:name].present?
      Material.search(params[:name])
    else
      Material.all
    end
    authorize Material
  end

  # GET /materials/1
  # GET /materials/1.json
  def show
    authorize @material
  end

  # GET /materials/new
  def new
    @material = Material.new
    @material.d_names.build if @material.d_names.blank?
    authorize @material
  end

  # GET /materials/1/edit
  def edit
    authorize @material
    @material.d_names.build if @material.d_names.blank?
  end

  # POST /materials
  # POST /materials.json
  def create
    @material = Material.new(material_params)
    authorize @material

    respond_to do |format|
      if @material.save
        format.html { redirect_to materials_url, notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @material }
      else
        format.html {
          @material.d_names.build if @material.d_names.blank?
          render :new
        }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    authorize @material
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to materials_url, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html {
          @material.d_names.build if @material.d_names.blank?
          render :edit
        }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    authorize @material
    @material.destroy
    respond_to do |format|
      format.html { redirect_to materials_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(
          :name,
          {tags: []},
          :unit_id,
          :price_per_unit,
          :inventory_type_id,
          d_names_attributes: [:id, :name, :price, :_destroy],
      )
    end
end
