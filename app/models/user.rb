class User < ApplicationRecord
    has_many :projects
    has_many :goals
    has_one :planner
    has_many :goal_tasks, through: :goals, source: :tasks
    has_many :project_tasks, through: :projects, source: :tasks
    has_many :planner_tasks, through: :planner, source: :tasks
    has_many :notes, through: :planner

    has_secure_password
    validates :username, uniqueness: {case_sensitive: false}

    def tasks_by_user
        [self.goal_tasks, self.project_tasks, self.planner_tasks].reduce([], :concat)
    end
end
