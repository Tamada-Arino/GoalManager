class Goal < ApplicationRecord
  validates :title, presence: true
  validate :start_end_check
  validate :validate_date_order(:schedules_end_date)
  validate :validate_date_order(:end_date)

  private

  def validate_date_order(target_date)
    if target_date.present? && self.start_date > self.target_date
      errors.add(target_date, :start_date_invalid)
    end
  end
end
