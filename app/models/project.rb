class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :delete_all
  accepts_nested_attributes_for :tasks, allow_destroy: true

  def completed_tasks
    self.tasks.where(is_completed: true).length
  end

  def total_tasks
    self.tasks.length
  end
end