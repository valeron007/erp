class SOthersController < ApplicationController
  before_action :set_s_other, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /s_others
  # GET /s_others.json
  def index
    authorize SOther
    @filterrific = initialize_filterrific(
        SOther,
        params[:filterrific],
        select_options: {
            with_storage_place: SOther.options_for_select_storage_place
        }
    ) or return

    @s_others = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /s_others/1
  # GET /s_others/1.json
  def show
    authorize @s_other
  end

  # GET /s_others/new
  def new
    @s_other = SOther.new
    authorize @s_other
  end

  # GET /s_others/1/edit
  def edit
    authorize @s_other
  end

  # POST /s_others
  # POST /s_others.json
  def create
    @s_other = SOther.new(s_other_params)
    authorize @s_other

    respond_to do |format|
      if @s_other.save
        format.html { redirect_to s_others_url, notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @s_other }
      else
        format.html { render :new }
        format.json { render json: @s_other.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /s_others/1
  # PATCH/PUT /s_others/1.json
  def update
    authorize @s_other
    files = @s_other.s_other_files
    files += s_other_params[:s_other_files] if s_other_params[:s_other_files]
    @s_other.assign_attributes(s_other_params)
    @s_other.s_other_files = files

    if params[:s_other_files_remove]

      remain_files = @s_other.s_other_files

      params[:s_other_files_remove].reverse_each do |file, state|
        if state.to_i == 1
          deleted_files = remain_files.delete_at(file.to_i)
          deleted_files.try(:remove!)
        end
      end

      @s_other.remove_s_other_files! if remain_files.empty?
    end
    respond_to do |format|
      if @s_other.save
        format.html { redirect_to s_others_url, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @s_other }
      else
        format.html { render :edit }
        format.json { render json: @s_other.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /s_others/1
  # DELETE /s_others/1.json
  def destroy
    authorize @s_other
    @s_other.destroy
    respond_to do |format|
      format.html { redirect_to s_others_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_s_other
      @s_other = SOther.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def s_other_params
      params.require(:s_other).permit(:name_id, :amount, :unit_id, :min_amount, :storage_place, :comments, {s_other_files: []})
    end
end
