class DeliveryLettersController < ApplicationController
  before_action :set_delivery_letter, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /delivery_letters
  # GET /delivery_letters.json
  def index
    authorize DeliveryLetter
    @delivery_letters = DeliveryLetter.all
  end

  # GET /delivery_letters/1
  # GET /delivery_letters/1.json
  def show
    authorize @delivery_letter
  end

  # GET /delivery_letters/new
  def new
    @delivery_letter = DeliveryLetter.new
    authorize @delivery_letter
  end

  # GET /delivery_letters/1/edit
  def edit
    authorize @delivery_letter
  end

  # POST /delivery_letters
  # POST /delivery_letters.json
  def create
    @delivery_letter = DeliveryLetter.new(delivery_letter_params)
    authorize @delivery_letter
    respond_to do |format|
      if @delivery_letter.save
        format.html { redirect_to @delivery_letter, notice: 'Delivery letter was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_letter }
      else
        format.html { render :new }
        format.json { render json: @delivery_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_letters/1
  # PATCH/PUT /delivery_letters/1.json
  def update
    authorize @delivery_letter
    respond_to do |format|
      if @delivery_letter.update(delivery_letter_params)
        format.html { redirect_to @delivery_letter, notice: 'Delivery letter was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_letter }
      else
        format.html { render :edit }
        format.json { render json: @delivery_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_letters/1
  # DELETE /delivery_letters/1.json
  def destroy
    authorize @delivery_letter
    @delivery_letter.destroy
    respond_to do |format|
      format.html { redirect_to delivery_letters_url, notice: 'Delivery letter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_letter
      @delivery_letter = DeliveryLetter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_letter_params
      params.require(:delivery_letter).permit(:name)
    end
end
