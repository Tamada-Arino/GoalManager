# frozen_string_literal: true

class Report < ApplicationRecord
  validates :target_date, presence: true, uniqueness: { scope: :goal_id }
  validates :progress_value, presence: true, numericality: { in: 0..100 }
  validate :progress_date_check

  belongs_to :goal

  private

  def progress_date_check
    if target_date < goal.start_date
      errors.add(:target_date, :start_date_invalid)
    elsif goal.end_date.present? && target_date > goal.end_date
      errors.add(:target_date, :end_date_invalid)
    end
  end
end
