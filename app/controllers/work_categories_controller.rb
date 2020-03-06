class WorkCategoriesController < ApplicationController
  before_action :set_work_category, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /work_categories
  # GET /work_categories.json
  def index
    authorize WorkCategory
    @filterrific = initialize_filterrific(
        WorkCategory,
        params[:filterrific]
    ) or return
    @selected_per_page = get_session_per_page(WorkCategory.per_page)
    @work_categories = @filterrific.find.page(params[:page]).per_page(@selected_per_page)
  end

  # GET /work_categories/1
  # GET /work_categories/1.json
  def show
    authorize @work_category
  end

  # GET /work_categories/new
  def new
    @work_category = WorkCategory.new
    authorize @work_category
    @work_category.work_type_categories.build if @work_category.work_type_categories.blank?
  end

  # GET /work_categories/1/edit
  def edit
    authorize @work_category
    @work_category.work_type_categories.build if @work_category.work_type_categories.blank?
  end

  # POST /work_categories
  # POST /work_categories.json
  def create
    @work_category = WorkCategory.new(work_category_params)
    authorize @work_category

    respond_to do |format|
      if @work_category.save
        format.html { redirect_to work_categories_url, notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @work_category }
      else
        format.html {
          @work_category.work_type_categories.build if @work_category.work_type_categories.blank?
          render :new
        }
        format.json { render json: @work_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_categories/1
  # PATCH/PUT /work_categories/1.json
  def update
    authorize @work_category
    respond_to do |format|
      if @work_category.update(work_category_params)
        format.html { redirect_to work_categories_url, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @work_category }
      else
        format.html {
          @work_category.work_type_categories.build if @work_category.work_type_categories.blank?
          render :edit
        }
        format.json { render json: @work_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_categories/1
  # DELETE /work_categories/1.json
  def destroy
    authorize @work_category
    @work_category.destroy
    respond_to do |format|
      format.html { redirect_to work_categories_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_category
      @work_category = WorkCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_category_params
      params.require(:work_category).permit(
          :name,
          work_type_categories_attributes: [:id, :work_type_id, :amount, :_destroy],
      )
    end
end
