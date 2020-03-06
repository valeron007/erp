class ToolsController < ApplicationController
  before_action :set_tool, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /tools
  # GET /tools.json
  def index
    @tools = if params[:name].present?
      Tool.search(params[:name])
    else
      Tool.all
    end
    authorize Tool
  end

  # GET /tools/1
  # GET /tools/1.json
  def show
    authorize @tool
  end

  # GET /tools/new
  def new
    @tool = Tool.new
    @tool.d_names.build if @tool.d_names.blank?
    authorize @tool
  end

  # GET /tools/1/edit
  def edit
    authorize @tool
    @tool.d_names.build if @tool.d_names.blank?
  end

  # POST /tools
  # POST /tools.json
  def create
    @tool = Tool.new(tool_params)
    authorize @tool

    respond_to do |format|
      if @tool.save
        format.html { redirect_to tools_url, notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @tool }
      else
        format.html {
          @tool.d_names.build if @tool.d_names.blank?
          render :new
        }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tools/1
  # PATCH/PUT /tools/1.json
  def update
    authorize @tool
    respond_to do |format|
      if @tool.update(tool_params)
        format.html { redirect_to tools_url, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @tool }
      else
        format.html {
          @tool.d_names.build if @tool.d_names.blank?
          render :edit
        }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tools/1
  # DELETE /tools/1.json
  def destroy
    authorize @tool
    @tool.destroy
    respond_to do |format|
      format.html { redirect_to tools_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool
      @tool = Tool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_params
      params.require(:tool).permit(
          :name,
          :price_per_unit,
          {tags: []},
          :inventory_type_id,
          d_names_attributes: [:id, :name, :price, :_destroy],
      )
    end
end
