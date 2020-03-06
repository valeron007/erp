class SToolsController < ApplicationController
  before_action :set_s_tool, only: [:show, :edit, :update, :destroy, :get_current_location]
  after_action :verify_authorized

  # GET /s_tools
  # GET /s_tools.json
  def index
    authorize STool
    @filterrific = initialize_filterrific(
        STool,
        params[:filterrific],
        select_options: {
            states: [[t(:new), :new], [t(:good), :good] , [t(:normal),:normal], [t(:bad),:bad], [t(:need_repair),:need_repair]],
            with_storage_place: STool.options_for_select_storage_place,
            with_locations: Facility.options_for_select,
            with_trashed: [true, false]
        }
    ) or return

    @selected_per_page = get_session_per_page(STool.per_page)

    @s_tools = @filterrific.find.page(params[:page]).per_page(@selected_per_page)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /s_tools/1
  # GET /s_tools/1.json
  def show
    authorize @s_tool
    set_return_to
    @return_to = get_return_to_or_default s_tools_url
  end

  # GET /s_tools/new
  def new
    @s_tool = STool.new
    authorize @s_tool
    set_return_to
    @return_to = get_return_to_or_default s_tools_url
  end

  # GET /s_tools/1/edit
  def edit
    authorize @s_tool
    set_return_to
    @return_to = get_return_to_or_default s_tools_url
  end

  # POST /s_tools
  # POST /s_tools.json
  def create
    @s_tool = STool.new(s_tool_params)
    authorize @s_tool

    respond_to do |format|
      if @s_tool.save
        format.html { redirect_back_or_default s_tools_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @s_tool }
      else
        format.html { render :new }
        format.json { render json: @s_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /s_tools/1
  # PATCH/PUT /s_tools/1.json
  def update
    authorize @s_tool
    files = @s_tool.s_tool_files
    files += s_tool_params[:s_tool_files] if s_tool_params[:s_tool_files]
    @s_tool.assign_attributes(s_tool_params)
    @s_tool.s_tool_files = files

    if params[:s_tool_files_remove]

      remain_files = @s_tool.s_tool_files

      params[:s_tool_files_remove].reverse_each do |file, state|
        if state.to_i == 1
          deleted_files = remain_files.delete_at(file.to_i)
          deleted_files.try(:remove!)
        end
      end

      @s_tool.remove_s_tool_files! if remain_files.empty?
    end
    respond_to do |format|
      if @s_tool.save
        format.html { redirect_back_or_default s_tools_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @s_tool }
      else
        format.html { render :edit }
        format.json { render json: @s_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /s_tools/1
  # DELETE /s_tools/1.json
  def destroy
    authorize @s_tool
    @s_tool.destroy
    set_return_to
    respond_to do |format|
      format.html { redirect_back_or_default s_tools_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  # GET /s_tools/update_locations
  def update_locations
    authorize STool
    STool.all.each{ |r|
      r.update_tool_location
      r.save
    }
    set_return_to
    redirect_back_or_default s_tools_url, t('Records has been updated')
  end

  def get_current_location
    authorize STool
    render json: { location: @s_tool.location_as_string }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_s_tool
      @s_tool = STool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def s_tool_params
      params.require(:s_tool).permit(
          :name_id,
          :description,
          :serial_number,
          :inventory_number,
          :rfid_tag,
          :barcode_tag,
          :consist,
          :min_amount,
          :storage_place,
          :state,
          :comments,
          {s_tool_files: []}
      )
    end
end
