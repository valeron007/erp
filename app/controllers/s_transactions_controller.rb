class STransactionsController < ApplicationController
  before_action :set_s_transaction, only: [:show, :details, :edit, :update, :destroy, :create_error]
  after_action :verify_authorized


  # GET /s_transactions
  # GET /s_transactions.json
  def index
    authorize STransaction
    @filterrific = initialize_filterrific(
        STransaction,
        params[:filterrific],
        select_options: {
            with_source_id: Facility.options_for_select,
            with_user_from_id: User.options_for_select,
            with_user_to_id: User.options_for_select
        }
    ) or return

    @selected_per_page = get_session_per_page(STransaction.per_page)
    @s_transactions = @filterrific.find.by_created_date.page(params[:page]).per_page(@selected_per_page)
    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /s_transactions/1
  # GET /s_transactions/1.json
  def show
    authorize @s_transaction
    @s_transaction_note = STransactionNote.new(s_transaction: @s_transaction)
  end

  def details
    authorize @s_transaction
    respond_to do |format|
      format.js if request.xhr?
      format.html { render :nothing => true, :status => 406 }
    end
  end

  # GET /s_transactions/new
  def new
    @s_transaction = STransaction.new
    @s_transaction.s_transaction_materials.build if @s_transaction.s_transaction_materials.blank? 
    @s_transaction.s_transaction_tools.build if @s_transaction.s_transaction_tools.blank?
    @s_transaction.s_transaction_others.build if @s_transaction.s_transaction_others.blank?
    @s_transaction.s_transaction_additionals.build if @s_transaction.s_transaction_additionals.blank?
    authorize @s_transaction
    set_return_to
    @return_to = get_return_to_or_default s_transactions_url
  end

  # GET /s_transactions/1/edit
  def edit
    authorize @s_transaction
    @s_transaction.s_transaction_materials.build if @s_transaction.s_transaction_materials.blank?
    @s_transaction.s_transaction_tools.build if @s_transaction.s_transaction_tools.blank?
    @s_transaction.s_transaction_others.build if @s_transaction.s_transaction_others.blank?
    @s_transaction.s_transaction_additionals.build if @s_transaction.s_transaction_additionals.blank?
    set_return_to
    @return_to = get_return_to_or_default s_transactions_url
  end

  # POST /s_transactions
  # POST /s_transactions.json
  def create
    @s_transaction = STransaction.new(s_transaction_params)
    # @xren = $xrel 
    #      if @xren == 0
    #       then 
    #        authorize @s_transaction
    #       else
    #        @s_transaction.destroy
    #      end 
    authorize @s_transaction

    respond_to do |format|
      if @s_transaction.save
        format.html { redirect_back_or_default s_transactions_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @s_transaction }

      else
        format.html {
          @s_transaction.s_transaction_materials.build if @s_transaction.s_transaction_materials.blank?
          @s_transaction.s_transaction_tools.build if @s_transaction.s_transaction_tools.blank?
          @s_transaction.s_transaction_others.build if @s_transaction.s_transaction_others.blank?
          @s_transaction.s_transaction_additionals.build if @s_transaction.s_transaction_additionals.blank?
          render :new
        }
        format.json { render json: @s_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /s_transactions/1
  # PATCH/PUT /s_transactions/1.json
  def update
    authorize @s_transaction
    @s_transaction.current_user = current_user
    respond_to do |format|
      if @s_transaction.update(s_transaction_params)
        format.html { redirect_back_or_default s_transactions_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @s_transaction }
      else
        format.html {
          @s_transaction.s_transaction_materials.build if @s_transaction.s_transaction_materials.blank?
          @s_transaction.s_transaction_tools.build if @s_transaction.s_transaction_tools.blank?
          @s_transaction.s_transaction_others.build if @s_transaction.s_transaction_others.blank?
          @s_transaction.s_transaction_additionals.build if @s_transaction.s_transaction_additionals.blank?
          render :edit
        }
        format.json { render json: @s_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /s_transactions/1
  # DELETE /s_transactions/1.json
  def destroy
    authorize @s_transaction
    @s_transaction.destroy
    respond_to do |format|
      format.html { redirect_back_or_default s_transactions_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  def destroy_note
    authorize STransaction
    @s_transaction_note = STransactionNote.find_by_id(params[:id])
    @s_transaction = @s_transaction_note.s_transaction
    @s_transaction_note.destroy

    respond_to do |format|
      format.html { redirect_to s_transaction_url(@s_transaction), notice: t('Note removed') }
      format.json { head :no_content }
    end
  end

  def create_note
    authorize STransaction
    @s_transaction_note = STransactionNote.new(s_transaction_note_params)
    @s_transaction = @s_transaction_note.s_transaction
    @s_transaction_note.user = current_user

    respond_to do |format|
      if @s_transaction_note.save
        format.html { redirect_to s_transaction_url(@s_transaction), notice: t('Note added') }
        format.json { render :show, status: :created, location: @s_transaction_note.s_transaction }
      else
        format.html { render :show }
        format.json { render json: @s_transaction_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_error
    authorize @s_transaction

    @s_transaction.error_text = s_transaction_params[:error_text]

    p s_transaction_url(@s_transaction)

    respond_to do |format|
      if @s_transaction.save
        format.html { redirect_to s_transaction_url(@s_transaction), notice: t('Record has been saved') }
        format.js { render :create_error, status: :created, location: @s_transaction }
      else
        format.html { render :edit }
        format.js { render json: @s_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_s_transaction
      @s_transaction = STransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def s_transaction_params
      params.require(:s_transaction).permit(
          :date,
          :destination_id,
          :source_id,
          :user_from_id,
          :user_to_id,
          :driver_id,
          :employee_id,
          :operation_type,
          :comments,
          :error_text,
          :document_number,
          s_transaction_materials_attributes: [:id, :s_material_id, :s_transaction_id, :s_amount, :_destroy],
          s_transaction_others_attributes: [:id, :s_other_id, :s_transaction_id, :s_amount, :_destroy],
          s_transaction_additionals_attributes: [:id, :s_additional_id, :s_transaction_id, :s_amount, :_destroy],
          s_transaction_tools_attributes: [:id, :s_tool_id, :s_transaction_id, :s_tool_state, :s_comment, :_destroy],
      )
    end

    def s_transaction_note_params
      params.require(:s_transaction_note).permit(:s_transaction_id, :val, :updated_by)
    end
end
