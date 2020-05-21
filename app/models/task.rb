class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :goal, optional: true
  belongs_to :planner, optional: true
end
