class Goal < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validate :start_date_check

  private

  def start_date_check
    validate_date_order(:schedules_end_date)
    validate_date_order(:end_date)
  end

  def validate_date_order(target_date)
    if send(target_date).present? && start_date > send(target_date)
      errors.add(target_date, :start_date_invalid)
    end
  end
end
