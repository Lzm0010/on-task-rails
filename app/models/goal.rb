class Goal < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :delete_all
  accepts_nested_attributes_for :tasks, allow_destroy: true

  def create_tasks_for_goal
    case self.goal_type
    when "total"
      self.create_tasks_for_total
    when "percentage"
      self.create_tasks_for_percentage
    end
  end

  def destroy_tasks
    self.tasks.destroy_all
  end

  private

  def number_of_days
    (self.end_date.to_date - self.start_date.to_date).to_i + 1
  end

  def frequency_as_int
    case self.frequency
    when "daily"
      1
    when "eoday"
      2
    when "weekly"
      7
    when "biweekly"
      14
    when "monthly"
      30
    when "bimonthly"
      60
    else
      1
    end
  end

  def create_tasks_for_total
    days = self.number_of_days / self.frequency_as_int
    interval = self.frequency_as_int
    days.times do |index|
      Task.create(
        name: self.name,
        goal_id: self.id,
        status: 'active',
        is_completed: false,
        date: self.start_date.to_date + (index * interval).day
      )
    end
  end

  def create_tasks_for_percentage
    days = self.number_of_days / self.frequency_as_int
    interval = self.frequency_as_int
    days.times do |index|
      Task.create(
        name: self.name,
        goal_id: self.id,
        status: 'active',
        is_completed: false,
        date: self.start_date.to_date + (index * interval).day
      )
    end
  end
end
