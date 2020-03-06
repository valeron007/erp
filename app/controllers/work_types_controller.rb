class WorkTypesController < ApplicationController
  before_action :set_work_type, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /work_types
  # GET /work_types.json
  def index
    authorize WorkType
    @filterrific = initialize_filterrific(
        WorkType,
        params[:filterrific]
    ) or return
    @selected_per_page = get_session_per_page(WorkType.per_page)
    @work_types = @filterrific.find.page(params[:page]).per_page(@selected_per_page)
  end

  # GET /work_types/1
  # GET /work_types/1.json
  def show
    authorize @work_type
  end

  # GET /work_types/new
  def new
    @work_type = WorkType.new
    authorize @work_type
    @work_type.work_type_tools.build if @work_type.work_type_tools.blank?
    @work_type.work_type_materials.build if @work_type.work_type_materials.blank?
    @work_type.work_type_others.build if @work_type.work_type_others.blank?
    @work_type.work_type_additionals.build if @work_type.work_type_additionals.blank?
  end

  # GET /work_types/1/edit
  def edit
    authorize @work_type
    @work_type.work_type_tools.build if @work_type.work_type_tools.blank?
    @work_type.work_type_materials.build if @work_type.work_type_materials.blank?
    @work_type.work_type_others.build if @work_type.work_type_others.blank?
    @work_type.work_type_additionals.build if @work_type.work_type_additionals.blank?
  end

  # POST /work_types
  # POST /work_types.json
  def create
    @work_type = WorkType.new(work_type_params)
    authorize @work_type

    respond_to do |format|
      if @work_type.save
        format.html { redirect_to work_types_url, notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @work_type }
      else
        format.html {
          @work_type.work_type_tools.build if @work_type.work_type_tools.blank?
          @work_type.work_type_materials.build if @work_type.work_type_materials.blank?
          @work_type.work_type_others.build if @work_type.work_type_others.blank?
          @work_type.work_type_additionals.build if @work_type.work_type_additionals.blank?
          render :new
        }
        format.json { render json: @work_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_types/1
  # PATCH/PUT /work_types/1.json
  def update
    authorize @work_type
    respond_to do |format|
      if @work_type.update(work_type_params)
        format.html { redirect_to work_types_url, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @work_type }
      else
        format.html {
          @work_type.work_type_tools.build if @work_type.work_type_tools.blank?
          @work_type.work_type_materials.build if @work_type.work_type_materials.blank?
          @work_type.work_type_others.build if @work_type.work_type_others.blank?
          @work_type.work_type_additionals.build if @work_type.work_type_additionals.blank?
          render :edit
        }
        format.json { render json: @work_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_types/1
  # DELETE /work_types/1.json
  def destroy
    authorize @work_type
    @work_type.destroy
    respond_to do |format|
      format.html { redirect_to work_types_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_type
      @work_type = WorkType.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_type_params
      params.require(:work_type).permit(
          :name,
          :unit_id,
          :price_per_unit,
          :facility_id,
          work_type_tools_attributes: [:id, :tool_id, :amount, :_destroy],
          work_type_materials_attributes: [:id, :material_id, :amount, :_destroy],
          work_type_others_attributes: [:id, :other_id, :amount, :_destroy],
          work_type_additionals_attributes: [:id, :additional_id, :amount, :_destroy]
      )
    end
end
