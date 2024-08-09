# frozen_string_literal: true

class SmallGoal < ApplicationRecord
  validates :title, presence: true
  validate :validate_small_goal_count

  belongs_to :goal
  has_many :reports, dependent: :nullify

  def validate_small_goal_count
    return unless goal.small_goals.count > 3

    goal.errors.add(:base, :over_small_goals_count)
  end
end
