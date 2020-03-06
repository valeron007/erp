class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :history]
  after_action :verify_authorized

  # GET /documents
  # GET /documents.json
  def index
    authorize Document
    @documents = Document.for_user(current_user)
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    authorize @document
  end

  # GET /documents/new
  def new
    @document = Document.new
    authorize @document
  end

  # GET /documents/1/edit
  def edit
    authorize @document
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.created_by = current_user
    authorize @document

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: t('Record has been saved') }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    authorize @document
    @document.updated_by = current_user
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: t('Record has been saved') }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    authorize @document
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  def history
    authorize @document
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(
          :name,
          :content,
          :created_by_id,
          :updated_by_id,
          :document_type,
          :sheet_content,
          roles: []
      )
    end
end
