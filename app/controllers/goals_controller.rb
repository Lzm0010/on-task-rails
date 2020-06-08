class GoalsController < ApplicationController
    def index
        goals = Goal.all
        render json: goals.to_json(:include => {
            :tasks => {:only => [:id, :name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date]}
        })
    end

    def create
        goal = Goal.create(goal_params)
        goal.create_tasks_for_goal
        if goal
            render json: goal.to_json(:include => {
                :tasks => {:only => [:id, :name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date]}
            })
        else
            render json: {"message": "Goal couldn't be created."}
        end
    end

    def update
        goal = Goal.find(params[:id])
        goal.destroy_tasks
        goal.update(goal_params)
        goal.create_tasks_for_goal
        goal.reload.tasks
        if goal
            render json: goal.to_json(:include => {
                :tasks => {:only => [:id, :name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date]}
            })
        else
            render json: {"message": "Something went wrong!"}
        end
    end

    def destroy
        goal = Goal.find(params[:id])
        if goal.destroy
            render json: goal.to_json(:include => {
                :tasks => {:only => [:id, :name, :step_number, :project_id, :goal_id, :planner_id, :status, :is_completed, :date]}
            })
        else
            render json: {"message": "Couldn't delete goal."}
        end
    end

    private
    
    def goal_params
        params.require(:goal).permit(:name, :start_date, :end_date, :goal_type, :goal_total_days, :goal_percentage, :user_id, :frequency, tasks_attributes: [:id, :name, :status, :is_completed, :date, :goal_id])
    end
    
end
