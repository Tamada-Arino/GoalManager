# frozen_string_literal: true

class Goal < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :color, presence: true
  validate :color_check
  validate :start_date_check

  belongs_to :user
  has_many :reports, dependent: :destroy

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

  def generate_calender(range)
    last_date = end_date || Time.zone.today
    start_date = [last_date - range, self.start_date].max
    reports = self.reports.where(target_date: start_date..last_date)
                  .select(:target_date, :progress_value)
                  .index_by(&:target_date)

    if range == 2.months
      progress_table(start_date, last_date, reports)
    else
      progress_line(start_date, last_date, reports)
    end
  end

  private

  def progress_table(start_date, last_date, reports)
    calendar = []
    week = initialize_week(start_date.wday)

    (start_date..last_date).each do |date|
      week << progress_number(reports[date]&.progress_value)
      if date.saturday? || date == last_date
        calendar << week
        week = []
      end
    end
    calendar
  end

  def initialize_week(start_date)
    [''] * start_date
  end

  def progress_line(start_date, last_date, reports)
    (start_date..last_date).map do |date|
      progress_number(reports[date]&.progress_value)
    end
  end

  def progress_number(progress_value)
    return 5 if progress_value.nil?

    if progress_value >= 75
      1
    elsif progress_value >= 50
      2
    elsif progress_value >= 25
      3
    else
      4
    end
  end

  def start_date_check
    %i[schedules_end_date end_date].each do |target_date|
      next unless send(target_date).present? && start_date > send(target_date)

      errors.add(target_date, :start_date_invalid)
    end
  end

  def color_check
    colors = %w[red green blue]
    return if colors.include?(color)

    errors.add(color, :invalid_color)
  end
end
