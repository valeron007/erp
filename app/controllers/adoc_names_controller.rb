class AdocNamesController < ApplicationController
  include AccessHelper

  before_action :set_adoc_name, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /adoc_names
  # GET /adoc_names.json
  def index
    authorize AdocName
    @adoc_names = AdocName.all
  end

  # GET /adoc_names/1
  # GET /adoc_names/1.json
  def show
    authorize @adoc_name
  end

  # GET /adoc_names/new
  def new
    @adoc_name = AdocName.new
    authorize @adoc_name
  end

  # GET /adoc_names/1/edit
  def edit
    authorize @adoc_name
  end

  # POST /adoc_names
  # POST /adoc_names.json
  def create
    @adoc_name = AdocName.new(adoc_name_params)
    authorize @adoc_name
    respond_to do |format|
      if @adoc_name.save
        format.html { redirect_to @adoc_name, notice: 'Adoc name was successfully created.' }
        format.json { render :show, status: :created, location: @adoc_name }
      else
        format.html { render :new }
        format.json { render json: @adoc_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adoc_names/1
  # PATCH/PUT /adoc_names/1.json
  def update
    authorize @adoc_name
    respond_to do |format|
      if @adoc_name.update(adoc_name_params)
        format.html { redirect_to @adoc_name, notice: 'Adoc name was successfully updated.' }
        format.json { render :show, status: :ok, location: @adoc_name }
      else
        format.html { render :edit }
        format.json { render json: @adoc_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adoc_names/1
  # DELETE /adoc_names/1.json
  def destroy
    authorize @adoc_name
    @adoc_name.destroy
    respond_to do |format|
      format.html { redirect_to adoc_names_url, notice: 'Adoc name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adoc_name
      @adoc_name = AdocName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adoc_name_params
      params.require(:adoc_name).permit(:name)
    end
end
