# frozen_string_literal: true

# Controller to common users interaction with tasks
class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :set_content
  before_action :set_task, only: %i[update destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    set_content
    respond_to do |format|
      format.html {}
      format.js { render :update }
    end

  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        set_content
        format.js { render :update }
      else
        format.js { render :error, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(task_params)
        set_content
        if task_params[:description].present? || task_params[:due_at].present?
          format.js { head :no_content }
        else
          format.js {}
        end
      else
        format.js { render :error, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    respond_to do |format|
      if @task.destroy
        set_content
        format.js { render :update }
      else
        format.js { render :error, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = @tasks.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    if params[:task].present?
      params.require(:task).permit(:title, :description, :due_at, :completed, :category_id)
    else
      {}
    end
  end

  def set_content
    @categories = current_user.categories
    if task_params[:category_id].present? && task_params[:category_id] != 'undefined'
      @category = @categories.find(task_params[:category_id])
      @tasks = @category.tasks.order(created_at: :desc, due_at: :asc)
    else
      @tasks = current_user.tasks.order(created_at: :desc, due_at: :asc)
    end
  end
end
