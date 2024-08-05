class SmallGoal < ApplicationRecord
  validates :title,  presence: true

  belongs_to :goal
  has_many :reports

  def validate_small_goal_count
    if goal.small_goals.count >= 3
      errors.add(:base, :over_small_goals_count)
    end
  end
end
