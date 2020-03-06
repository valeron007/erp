class TasksController < ApplicationController
  include AccessHelper

  before_action :set_task, only: [:show, :edit, :update, :destroy, :close, :open, :history]
  before_action :set_paper_trail_whodunnit, only: [:update, :create_note, :destroy_note]
  after_action :verify_authorized

  # GET /tasks
  # GET /tasks.json
  def index
    authorize Task
    @filterrific = initialize_filterrific(
        Task,
        params[:filterrific],
        select_options: {
            with_task_status_id: TaskStatus.options_for_select,
            with_assigned_to_id: User.options_for_select
        },
    ) or return

    #@filterrific.sorted_by = 'task_status_asc' if @filterrific.sorted_by.blank?

    @selected_per_page = get_session_per_page(Task.per_page)
    if @filterrific.with_task_status_id.nil?
      @tasks = @filterrific.find.for_user(current_user).not_closed.page(params[:page]).per_page(@selected_per_page)
    else
      @tasks = @filterrific.find.for_user(current_user).page(params[:page]).per_page(@selected_per_page)
    end
    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    authorize @task
    @task_note = TaskNote.new(task: @task)
    set_return_to
    @return_to = get_return_to_or_default tasks_url
  end

  # GET /tasks/new
  def new
    @task = Task.new
    authorize @task
    @task.assigned_by = current_user
    @task.assigned_to = current_user
    set_return_to
    @return_to = get_return_to_or_default tasks_url
  end

  # GET /tasks/1/edit
  def edit
    authorize @task
    set_return_to
    @return_to = get_return_to_or_default tasks_url
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.created_by = current_user
    authorize @task
    unless can_change_task_owner(@task)
      @task.assigned_by = current_user
    end
    respond_to do |format|
      if @task.save
        format.html { redirect_back_or_default tasks_url, t('Record has been saved') }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    authorize @task
    @task.updated_by = current_user

    files = @task.files
    files += task_params[:files] if task_params[:files]
    @task.assign_attributes(task_params)
    @task.files = files

    if params[:files_remove]

      remain_files = @task.files

      params[:files_remove].reverse_each do |file, state|
        if state.to_i == 1
          deleted_files = remain_files.delete_at(file.to_i)
          deleted_files.try(:remove!)
        end
      end

      @task.remove_files! if remain_files.empty?
    end
    respond_to do |format|
      if @task.save
        format.html { redirect_back_or_default tasks_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    authorize @task
    set_return_to
    @task.destroy
    respond_to do |format|
      format.html { redirect_back_or_default tasks_url, t('Record has been deleted') }
      format.json { head :no_content }
    end
  end

  def destroy_note
    @task_note = TaskNote.find_by_id(params[:id])
    @task = @task_note.task
    authorize @task
    @task_note.destroy

    respond_to do |format|
      format.html { redirect_to task_url(@task), notice: t('Note removed') }
      format.json { head :no_content }
    end
  end

  def create_note
    @task_note = TaskNote.new(task_note_params)
    @task = @task_note.task
    authorize @task
    @task_note.user = current_user

    respond_to do |format|
      if @task_note.save
        format.html { redirect_to task_url(@task), notice: t('Note added') }
        format.json { render :show, status: :created, location: @task_note.task }
      else
        format.html { render :show }
        format.json { render json: @task_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    authorize @task
    set_return_to
    @task.updated_by = current_user
    @task.task_status_id = TaskStatus.finished_id
    respond_to do |format|
      if @task.save
        format.html { redirect_back_or_default tasks_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def open
    authorize @task
    set_return_to
    @task.updated_by = current_user
    @task.task_status_id = TaskStatus.assigned_id
    respond_to do |format|
      if @task.save
        format.html { redirect_back_or_default tasks_url, t('Record has been saved') }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def history
    authorize @task
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(
          :title,
          :desc,
          :assign_date,
          :finish_date,
          :task_status_id,
          :important,
          :urgent,
          :assigned_by_id,
          :assigned_to_id,
          :created_by_id,
          :updated_by_id,
          :regularly,
          :result,
          {files: []}
      )
    end

    def task_note_params
      params.require(:task_note).permit(:task_id, :val, :updated_by)
    end
end
