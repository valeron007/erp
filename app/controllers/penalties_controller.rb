class PenaltiesController < ApplicationController
  before_action :set_penalty, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /penalties
  # GET /penalties.json
  def index
    @penalties = Penalty.all
    authorize Penalty
  end

  # GET /penalties/1
  # GET /penalties/1.json
  def show
    authorize @penalty
  end

  # GET /penalties/new
  def new
    @penalty = Penalty.new
    authorize @penalty
  end

  # GET /penalties/1/edit
  def edit
    authorize @penalty
  end

  # POST /penalties
  # POST /penalties.json
  def create
    @penalty = Penalty.new(penalty_params)
    authorize @penalty

    respond_to do |format|
      if @penalty.save
        format.html { redirect_to @penalty, notice: 'Penalty was successfully created.' }
        format.json { render :show, status: :created, location: @penalty }
        format.js { render :show, status: :created, location: @penalty }
      else
        format.html { render :new }
        format.json { render json: @penalty.errors, status: :unprocessable_entity }
        format.js { render json: @penalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /penalties/1
  # PATCH/PUT /penalties/1.json
  def update
    authorize @penalty
    respond_to do |format|
      if @penalty.update(penalty_params)
        format.html { redirect_to @penalty, notice: 'Penalty was successfully updated.' }
        format.json { render :show, status: :ok, location: @penalty }
      else
        format.html { render :edit }
        format.json { render json: @penalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /penalties/1
  # DELETE /penalties/1.json
  def destroy
    authorize @penalty
    @penalty.destroy
    respond_to do |format|
      format.html { redirect_to penalties_url, notice: 'Penalty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_penalty
      @penalty = Penalty.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def penalty_params
      params.require(:penalty).permit(:name, :penalty_rate)
    end
end
