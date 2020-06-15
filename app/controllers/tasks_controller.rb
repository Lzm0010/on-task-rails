class TasksController < ApplicationController
    def index
        tasks = current_user.tasks_by_user.sort_by &:created_at
        render json: tasks
    end

    def show
        task = Task.find(params[:id])
        render json: task
    end

    def create
        task = Task.new(task_params)
        if task.save
            render json: task
        else
            render json: {"message": "task couldn't be created."}
        end
    end

    def update
        task = Task.find(params[:id])
        if task.update(task_params)
            render json: task
        else
            render json: {"message": "Something went wrong!"}
        end
    end

    def destroy
        task = Task.find(params[:id])
        if task.destroy
            render json: task
        else
            render json: {"message": "Couldn't delete task."}
        end
    end

    private
    
    def task_params
        params.require(:task).permit(:name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date)
    end
end
