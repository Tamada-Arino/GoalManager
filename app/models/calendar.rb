# frozen_string_literal: true

class Calendar
  def initialize(goal, range)
    @goal = goal
    @range = range
    @range_last_date = @goal.end_date || Time.zone.today
    @range_start_date = [@range_last_date - @range, @goal.start_date].max
    @target_reports = build_target_reports
  end

  def generate_calendar
    calendar = []
    week = [{}] * @range_start_date.wday

    (@range_start_date..@range_last_date).each do |date|
      week << target_date_datas(@target_reports[date], date)

      if date.saturday? || date == @range_last_date
        calendar << week
        week = []
      end
    end
    calendar
  end

  def generate_line
    (@range_start_date..@range_last_date).map do |date|
      target_date_datas(@target_reports[date], date)
    end
  end

  private

  attr_reader :goal, :range, :range_last_date, :range_start_date, :target_reports

  OFFSET_NUMBER = 1
  THRESHOLD_NUMBER = 25
  DARKEN_VALUE = 50

  def build_target_reports
    reports_hash = {}
    @goal.reports.each do |report|
      if (@range_start_date..@range_last_date).cover?(report.target_date)
        reports_hash[report.target_date] = report.progress_value
      end
    end

    reports_hash
  end

  def target_date_datas(progress_value, target_date)
    date_datas = { class: 'date_cell' }
    if progress_value.present?
      status_number = build_status_number(progress_value)
      date_datas[:style] = "background-color: #{get_rgba(@goal.color, status_number)}"
      date_datas[:target_date] = target_date
    end

    date_datas
  end

  def build_status_number(progress_value)
    ((progress_value - OFFSET_NUMBER) / THRESHOLD_NUMBER) + OFFSET_NUMBER
  end

  def get_rgba(hex_color, value)
    hex_color = hex_color.delete('#')

    rgb_array = [hex_color[0..1].to_i(16),
                 hex_color[2..3].to_i(16),
                 hex_color[4..5].to_i(16)]

    darken_color_value(rgb_array) if value == 4
    opacity = get_opacity(value)
    "rgba(#{rgb_array[0]}, #{rgb_array[1]}, #{rgb_array[2]}, #{opacity});"
  end

  def get_opacity(value)
    case value
    when 2
      0.6
    when 1
      0.3
    else
      1
    end
  end

  def darken_color_value(rgb_array)
    rgb_array.map! do |value|
      [value - DARKEN_VALUE, 0].max
    end
  end
end
