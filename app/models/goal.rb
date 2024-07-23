# frozen_string_literal: true

class Goal < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validate :start_date_check

  belongs_to :user

  def status
    if end_date.present?
      '完了'
    elsif interrupted
      '中断中'
    elsif start_date > Time.zone.today
      '開始前'
    else
      '進行中'
    end
  end

  private

  def start_date_check
    %i[schedules_end_date end_date].each do |target_date|
      next unless send(target_date).present? && start_date > send(target_date)

      errors.add(target_date, :start_date_invalid)
    end
  end
end
