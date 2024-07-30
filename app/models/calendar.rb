# frozen_string_literal: true

class Calendar
  def initialize(goal, range)
    @goal = goal
    @range = range
    @range_last_date = @goal.end_date || Time.zone.today
    @range_start_date = [@range_last_date - @range, @goal.start_date].max
    @target_reports = @goal.reports
                           .where(target_date: @range_start_date..range_last_date)
                           .select(:target_date, :progress_value)
                           .index_by(&:target_date)
  end

  def generate_calendar
    calendar = []
    week = initialize_week(@range_start_date.wday)

    (@range_start_date..@range_last_date).each do |date|
      week << target_date_class_and_style(@target_reports[date]&.progress_value)

      if date.saturday? || date == @range_last_date
        calendar << week
        week = []
      end
    end
    calendar
  end

  def generate_line
    (@range_start_date..@range_last_date).map do |date|
      target_date_class_and_style(@target_reports[date]&.progress_value)
    end
  end

  private

  attr_reader :goal, :range, :range_last_date, :range_start_date, :target_reports

  def target_date_class_and_style(progress_value)
    class_with_style = { class: 'date_cell' }
    if progress_value.present?
      status_number = ((progress_value - 1) / 25) + 1
      class_with_style[:class] += " progress_#{status_number}"
      class_with_style[:style] = "background-color: #{@goal.color};"
    end

    class_with_style
  end

  def initialize_week(wday)
    [{}] * wday
  end
end
