class Goal < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :delete_all
  accepts_nested_attributes_for :tasks, allow_destroy: true

  def create_tasks_for_goal
    start = self.start_date.to_date
    if self.frequency_as_int >= 30
      days = (start..self.end_date.to_date).select {|d| d.day == start.day }
      days = self.frequency_as_int == 30 ? days : days.select.each_with_index{|d, i| d if i.even?}
      p days
      days.each do |day|
        Task.create(
          name: self.name,
          goal_id: self.id,
          status: 'active',
          is_completed: false,
          date: day
        )
      end
    else
      days = self.number_of_days / self.frequency_as_int
      interval = self.frequency_as_int
      days.times do |index|
        Task.create(
          name: self.name,
          goal_id: self.id,
          status: 'active',
          is_completed: false,
          date: start + (index * interval).day
        )
      end
    end
  end

  def destroy_tasks
    self.tasks.destroy_all
  end

  def percentage
    ((completed_tasks / total_tasks.to_f) * 100).to_i
  end

  def completed_tasks
    self.tasks.where(is_completed: true).length
  end

  def total_tasks
    self.tasks.length
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
      61
    else
      1
    end
  end

end
