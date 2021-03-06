class ProjectsController < ApplicationController
    def index
        projects = Project.where(user_id: current_user.id).sort_by &:created_at
        render json: projects.to_json(:include => {
            :tasks => {:only => [:id, :name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date]}
        }, :methods => [:completed_tasks, :total_tasks])
    end

    def create
        project = Project.new(project_params)
        if project.save
            render json: project.to_json(:include => {
                :tasks => {:only => [:id, :name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date]}
            })
        else
            render json: {"message": "project couldn't be created."}
        end
    end

    def update
        project = Project.find(params[:id])
        project.update(project_params)
        project.reload.tasks
        if project
            render json: project.to_json(:include => {
                :tasks => {:only => [:id, :name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date]}
            })
        else
            render json: {"message": "Something went wrong!"}
        end
    end

    def destroy
        project = Project.find(params[:id])
        if project.destroy
            render json: project.to_json(:include => {
                :tasks => {:only => [:id, :name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date]}
            })
        else
            render json: {"message": "Couldn't delete project."}
        end
    end

    private
    
    def project_params
        params.require(:project).permit(:name, :start_date, :end_date, :user_id, tasks_attributes: [:id, :name, :step_number, :status, :is_completed, :date, :project_id])
    end
end
