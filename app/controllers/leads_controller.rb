class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy, :create_error]
  after_action :verify_authorized

  # GET /leads
  # GET /leads.json
  def index
    authorize Lead
    @filterrific = initialize_filterrific(
        Lead,
        params[:filterrific],
        select_options: {
            with_lead_status_id: LeadStatus.options_for_select
        }
    ) or return

    @selected_per_page = get_session_per_page(Lead.per_page)
    if @filterrific.with_lead_status_id.nil?
      @leads = @filterrific.find.for_user(current_user).not_closed.page(params[:page]).per_page(@selected_per_page)
    else
      @leads = @filterrific.find.for_user(current_user).page(params[:page]).per_page(@selected_per_page)
    end

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /leads/1
  # GET /leads/1.json
  def show
    authorize @lead
    @lead_note = LeadNote.new(lead: @lead)
    set_return_to
    @return_to = get_return_to_or_default leads_url
  end

  # GET /leads/new
  def new
    @lead = Lead.new
    authorize @lead
    @client = Client.new
    @lead.lead_construction_types.build if @lead.lead_construction_types.blank?
    @lead.contacts.build if @lead.contacts.blank?
    set_return_to
    @return_to = get_return_to_or_default leads_url
  end

  # GET /leads/1/edit
  def edit
    authorize @lead
    @client = Client.new
    @lead.lead_construction_types.build if @lead.lead_construction_types.blank?
    @lead.contacts.build if @lead.contacts.blank?
    set_return_to
    @return_to = get_return_to_or_default leads_url
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(lead_params)
    @lead.created_by = current_user if @lead.created_by_id.blank?
    authorize @lead
    @client = Client.new
    respond_to do |format|
      if @lead.save
        format.html { redirect_back_or_default lead_url(@lead), t('Record has been saved') }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html {
          @lead.lead_construction_types.build if @lead.lead_construction_types.blank?
          @lead.contacts.build if @lead.contacts.blank?
          render :new
        }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  def update
    authorize @lead
    files = @lead.lead_files
    files += lead_params[:lead_files] if lead_params[:lead_files]
    @lead.assign_attributes(lead_params)
    @lead.lead_files = files
    @lead.updated_by = current_user

    if params[:lead_files_remove]

      remain_files = @lead.lead_files

      params[:lead_files_remove].reverse_each do |file, state|
        if state.to_i == 1
          deleted_files = remain_files.delete_at(file.to_i)
          deleted_files.try(:remove!)
        end
      end

      @lead.remove_lead_files! if remain_files.empty?

    end

    respond_to do |format|
      if @lead.save
        format.html { redirect_back_or_default lead_url(@lead), t('Record has been saved') }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html {
          @lead.lead_construction_types.build if @lead.lead_construction_types.blank?
          @lead.contacts.build if @lead.contacts.blank?
          render :edit
        }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    authorize @lead
    set_return_to
    @lead.destroy
    respond_to do |format|
      format.html { redirect_back_or_default leads_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  #POST
  def destroy_note
    @lead_note = LeadNote.find_by_id(params[:id])
    @lead = @lead_note.lead
    authorize @lead
    @lead_note.destroy

    respond_to do |format|
      format.html { redirect_to lead_url(@lead), notice: t('Note removed') }
      format.json { head :no_content }
    end
  end

  #POST
  def create_note
    @lead_note = LeadNote.new(lead_note_params)
    @lead = @lead_note.lead
    authorize @lead
    @lead_note.user = current_user

    respond_to do |format|
      if @lead_note.save
        format.html { redirect_to lead_url(@lead), notice: t('Note added') }
        format.json { render :show, status: :created, location: @lead_note.lead }
      else
        format.html { render :show }
        format.json { render json: @lead_note.errors, status: :unprocessable_entity }
      end
    end
  end

  #POST
  def create_error
    authorize @lead

    @lead.error_text = lead_params[:error_text]

    respond_to do |format|
      if @lead.save
        format.html { redirect_back_or_default lead_url(@lead), t('Record has been saved') }
        format.js { render :create_error, status: :created, location: @lead }
      else
        format.html { render :edit }
        format.js { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
      params.require(:lead).permit(
          :created_by_id,
          :name,
          :short_name,
          :client_id,
          :address,
          :visit_date,
          :lead_status_id,
          :lead_type_id,
          :lead_construction_type_id,
          :project,
          :project_institute,
          :gip,
          :gip_phone,
          :gap,
          :gap_phone,
          :project_help,
          :details,
          :representatives,
          :psycho01,
          :psycho02,
          :psycho03,
          :psycho04,
          :psycho05,
          :psycho06,
          :psycho07,
          :psycho08,
          :psycho09,
          :psycho10,
          :psycho11,
          :psycho12,
          :psycho13,
          :psycho_other,
          :sum_contract,
          :lead_payment_status_id,
          :sum_payment,
          :debt,
          :credit,
          :next_date,
          :next_visit_comment,
          :error_text,
          {lead_files: []},
          :lead_construction_type_ids => [],
          contacts_attributes: [:id, :name, :phone, :position, :_destroy],
      )
    end

    def lead_note_params
      params.require(:lead_note).permit(:lead_id, :val, :updated_by)
    end

end
