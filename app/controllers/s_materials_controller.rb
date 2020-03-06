class SMaterialsController < ApplicationController
  before_action :set_s_material, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /s_materials
  # GET /s_materials.json
  def index
    authorize SMaterial
    @filterrific = initialize_filterrific(
        SMaterial,
        params[:filterrific],
        select_options: {
            with_storage_place: SMaterial.options_for_select_storage_place
        }
    ) or return

    @s_materials = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /s_materials/1
  # GET /s_materials/1.json
  def show
    authorize @s_material
  end

  # GET /s_materials/new
  def new
    @s_material = SMaterial.new
    authorize @s_material
  end

  # GET /s_materials/1/edit
  def edit
    authorize @s_material
  end

  # POST /s_materials
  # POST /s_materials.json
  def create
    @s_material = SMaterial.new(s_material_params)
    authorize @s_material

    respond_to do |format|
      if @s_material.save
        format.html { redirect_to s_materials_url, notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @s_material }
      else
        format.html { render :new }
        format.json { render json: @s_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /s_materials/1
  # PATCH/PUT /s_materials/1.json
  def update
    authorize @s_material
    files = @s_material.s_material_files
    files += s_material_params[:s_material_files] if s_material_params[:s_material_files]
    @s_material.assign_attributes(s_material_params)
    @s_material.s_material_files = files

    if params[:s_material_files_remove]

      remain_files = @s_material.s_material_files

      params[:s_material_files_remove].reverse_each do |file, state|
        if state.to_i == 1
          deleted_files = remain_files.delete_at(file.to_i)
          deleted_files.try(:remove!)
        end
      end

      @s_material.remove_s_material_files! if remain_files.empty?
    end
    respond_to do |format|
      if @s_material.save
        format.html { redirect_to s_materials_url, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @s_material }
      else
        format.html { render :edit }
        format.json { render json: @s_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /s_materials/1
  # DELETE /s_materials/1.json
  def destroy
    authorize @s_material
    @s_material.destroy
    respond_to do |format|
      format.html { redirect_to s_materials_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_s_material
      @s_material = SMaterial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def s_material_params
      params.require(:s_material).permit(:name_id, :pack, :amount, :unit_id, :min_amount, :storage_place, :comments, {s_material_files: []})
    end
end
