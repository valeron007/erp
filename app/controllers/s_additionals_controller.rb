class SAdditionalsController < ApplicationController
  before_action :set_s_additional, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /s_additionals
  # GET /s_additionals.json
  def index
    authorize SAdditional
    @filterrific = initialize_filterrific(
        SAdditional,
        params[:filterrific],
        select_options: {
            with_storage_place: SAdditional.options_for_select_storage_place
        }
    ) or return

    @selected_per_page = get_session_per_page(SAdditional.per_page)
    @s_additionals = @filterrific.find.page(params[:page]).per_page(@selected_per_page)
    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /s_additionals/1
  # GET /s_additionals/1.json
  def show
    authorize @s_additional
    set_return_to
    @return_to = get_return_to_or_default s_additionals_url
  end

  # GET /s_additionals/new
  def new
    @s_additional = SAdditional.new
    authorize @s_additional
    set_return_to
    @return_to = get_return_to_or_default s_additionals_url
  end

  # GET /s_additionals/1/edit
  def edit
    authorize @s_additional
    set_return_to
    @return_to = get_return_to_or_default s_additionals_url
  end

  # POST /s_additionals
  # POST /s_additionals.json
  def create
    @s_additional = SAdditional.new(s_additional_params)
    authorize @s_additional

    respond_to do |format|
      if @s_additional.save
        format.html { redirect_back_or_default s_additionals_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @s_additional }
      else
        format.html { render :new }
        format.json { render json: @s_additional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /s_additionals/1
  # PATCH/PUT /s_additionals/1.json
  def update
    authorize @s_additional
    
    files = @s_additional.s_additional_files
    files += s_additional_params[:s_additional_files] if s_additional_params[:s_additional_files]
    @s_additional.assign_attributes(s_additional_params)
    @s_additional.s_additional_files = files

    if params[:s_additional_files_remove]

      remain_files = @s_additional.s_additional_files

      params[:s_additional_files_remove].reverse_each do |file, state|
        if state.to_i == 1
          deleted_files = remain_files.delete_at(file.to_i)
          deleted_files.try(:remove!)
        end
      end

      @s_additional.remove_s_additional_files! if remain_files.empty?
    end
    
    respond_to do |format|
      if @s_additional.save
        format.html { redirect_back_or_default s_additionals_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @s_additional }
      else
        format.html { render :edit }
        format.json { render json: @s_additional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /s_additionals/1
  # DELETE /s_additionals/1.json
  def destroy
    authorize @s_additional
    set_return_to
    @s_additional.destroy
    respond_to do |format|
      format.html { redirect_back_or_default s_additionals_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_s_additional
      @s_additional = SAdditional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def s_additional_params
      params.require(:s_additional).permit(
          :additional_id,
          :amount,
          :unit_id,
          :min_amount,
          :storage_place,
          :comments,
          {s_additional_files: []}
      )
    end
end
