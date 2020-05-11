class Task < ApplicationRecord
  belongs_to :project
  belongs_to :goal
  belongs_to :planner
end
