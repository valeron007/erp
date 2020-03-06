class DailyWorksController < ApplicationController
  before_action :set_daily_work, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized


  # GET /daily_works.xlsx
  def export
    authorize DailyWork

    @filterrific = initialize_filterrific(
        DailyWork,
        params[:filterrific],
        select_options: {
            with_user_id: User.options_for_select,
        }
    ) or return

    @daily_works = @filterrific.find.for_user(current_user)

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="daily_works_export.xlsx"'
      }
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /daily_works
  # GET /daily_works.json
  def index
    authorize DailyWork

    @filterrific = initialize_filterrific(
        DailyWork,
        params[:filterrific],
        select_options: {
            with_user_id: User.options_for_select,
        }
    ) or return

    @selected_per_page = get_session_per_page(DailyWork.per_page)
    @daily_works = @filterrific.find.for_user(current_user).page(params[:page]).per_page(@selected_per_page)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /daily_works/1
  # GET /daily_works/1.json
  def show
    authorize @daily_work
    set_return_to
    @return_to = get_return_to_or_default daily_works_url
  end

  # GET /daily_works/new
  def new
    @daily_work = DailyWork.new
    @daily_work.user = current_user
    authorize @daily_work
    @daily_work.daily_work_kpis.build if @daily_work.daily_work_kpis.blank?
    set_return_to
    @return_to = get_return_to_or_default daily_works_url
  end

  # GET /daily_works/1/edit
  def edit
    authorize @daily_work
    @daily_work.daily_work_kpis.build if @daily_work.daily_work_kpis.blank?
    set_return_to
    @return_to = get_return_to_or_default daily_works_url
  end

  # POST /daily_works
  # POST /daily_works.json
  def create
    @daily_work = DailyWork.new(daily_work_params)
    authorize @daily_work
    @daily_work.user = current_user unless policy(@daily_work).can_assign?

    respond_to do |format|
      if @daily_work.save
        format.html { redirect_back_or_default daily_works_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @daily_work }
      else
        format.html {
          @daily_work.daily_work_kpis.build if @daily_work.daily_work_kpis.blank?
          render :new
        }
        format.json { render json: @daily_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_works/1
  # PATCH/PUT /daily_works/1.json
  def update
    authorize @daily_work
    respond_to do |format|
      if @daily_work.update(daily_work_params)
        format.html { redirect_back_or_default daily_works_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @daily_work }
      else
        format.html {
          @daily_work.daily_work_kpis.build if @daily_work.daily_work_kpis.blank?
          render :edit
        }
        format.json { render json: @daily_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_works/1
  # DELETE /daily_works/1.json
  def destroy
    authorize @daily_work
    set_return_to
    @daily_work.destroy
    respond_to do |format|
      format.html { redirect_back_or_default daily_works_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_work
      @daily_work = DailyWork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_work_params
      params.require(:daily_work).permit(
          :date,
          :user_id,
          daily_work_kpis_attributes: [:id, :title, :kpi_id, :task_id, :hours, :comment, :_destroy],
      )
    end
end
