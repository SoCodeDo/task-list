

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)


    if @task.nil?
      head 302
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    task_params = params.require(:task).permit(:name, :description, :completed_at)
    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    task_params = params.require(:task).permit(:name, :description, :completed_at)
    if task.nil?
      redirect_to root_path
      return

    elsif @task.destroy(task_params)
      redirect_to root_path
      return
    end
  end

  def confirm
    @task = Task.find_by(id: params[:id])
  end

  def complete
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
    if @task[:completed_at].nil? || @task[:completed_at] == ""
      @task.update(completed_at: Time.now)
      redirect_to root_path
      return
    else
      @task.update(completed_at: nil)
      redirect_to root_path
      return
    end

  end
end

