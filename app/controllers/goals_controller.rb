class GoalsController < ApplicationController
    def index
        goals = Goal.all
        render json: goals
    end

    def create
        goal = Goal.new(goal_params)
        if goal.save
            render json: goal
        else
            render json: {"message": "Goal couldn't be created."}
        end
    end

    def update
        goal = Goal.find(params[:id])
        if goal.update_attributes(goal_params)
            render json: goal
        else
            render json: {"message": "Something went wrong!"}
        end
    end

    def destroy
        goal = Goal.find(params[:id])
        if goal.destroy
            render json: goal
        else
            render json: {"message": "Couldn't delete goal."}
        end
    end

    private
    
    def goal_params
        params.require(:goal).permit(:name, :start_date, :end_date, :goal_type, :goal_total_days, :goal_percentage, :user_id, :frequency)
    end
    
end
