class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /expenses.xlsx
  def export
    authorize Expense

    @filterrific = initialize_filterrific(
        Expense,
        params[:filterrific],
        select_options: {
            with_category_id: ExpenseCategory.options_for_select,
            with_expense_by_id: User.options_for_select,
        }
    ) or return

    @expenses = @filterrific.find.for_user(current_user)

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="expenses_export.xlsx"'
      }
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /expenses
  # GET /expenses.json
  def index
    authorize Expense

    @filterrific = initialize_filterrific(
        Expense,
        params[:filterrific],
        select_options: {
            with_category_id: ExpenseCategory.options_for_select,
            with_expense_by_id: User.options_for_select,
        }
    ) or return

    @selected_per_page = get_session_per_page(Expense.per_page)
    @expenses = @filterrific.find.for_user(current_user).page(params[:page]).per_page(@selected_per_page)

    @user_balance = Expense.user_balance(current_user)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    authorize @expense

    @expense.direction = Expense::DIRECTION_PLUS if params[:d] == "p"
    @expense.direction = Expense::DIRECTION_MINUS if params[:d] == "m"
    @expense.direction = Expense::DIRECTION_TRANSFER if params[:d] == "t"

    @expense.expense_by = current_user
    @expense.expense_date = Date.today
    set_return_to
    @return_to = get_return_to_or_default expenses_url
  end

  # GET /expenses/1/edit
  def edit
    authorize @expense
    set_return_to
    @return_to = get_return_to_or_default expenses_url
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)
    authorize @expense
    @expense.created_by = current_user
    @expense.expense_by = current_user unless policy(@expense).can_assign?
    respond_to do |format|
      if @expense.save
        format.html { redirect_back_or_default expenses_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    authorize @expense
    @expense.updated_by = current_user
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_back_or_default expenses_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    authorize @expense
    set_return_to
    @expense.destroy
    respond_to do |format|
      format.html { redirect_back_or_default expenses_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(
          :direction,
          :title,
          :amount,
          :company,
          :facility,
          :expense_category_id,
          :expense_by_id,
          :expense_to_id,
          :expense_date,
          :created_by_id,
          :updated_by_id
      )
    end
end
