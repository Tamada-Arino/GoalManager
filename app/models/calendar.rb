# frozen_string_literal: true

class Calendar
  attr_reader :goal, :range

  def initialize(goal, range)
    @goal = goal
    @range = range
  end

  def generate_calendar
    range_last_date = @goal.end_date || Time.zone.today
    range_start_date = [range_last_date - @range, @goal.start_date].max
    target_reports = @goal.reports
                          .where(target_date: range_start_date..range_last_date)
                          .select(:target_date, :progress_value)
                          .index_by(&:target_date)

    progress_table(range_start_date, range_last_date, target_reports)
  end

  private

  def progress_table(range_start_date, range_last_date, target_reports)
    calendar = []
    week = initialize_week(range_start_date.wday)

    (range_start_date..range_last_date).each do |date|
      week << class_and_style(progress_number(target_reports[date]&.progress_value))

      if date.saturday? || date == range_last_date
        calendar << week
        week = []
      end
    end
    calendar
  end

  def class_and_style(value)
    if value == 5
      { class: 'date_cell',
        style: '' }
    else
      { class: "date_cell progress_#{value}",
        style: "background-color: #{@goal.color};" }
    end
  end

  def initialize_week(wday)
    [{ class: '', style: '' }] * wday
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
end
