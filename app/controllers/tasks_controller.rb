# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit create update destroy]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new.(params.merge({ user_id: current_user.id }))
    @task.title = task_params[:title]
    @task.description = task_params[:description]
    @task.state = task_params[:state]
    @task.deadline = task_params[:deadline] 
    @task.user_id = task_params[:user_id]
  
    #@task = Task.new(params[:task, :user_id ]) 
   # @task = Task.new(params.merge({ user_id: current_user.id }))

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_url(@task), alert: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), alert: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to root_url, alert: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :state, :deadline, :deleted_at, :user_id)
  end
end
