# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update destroy]
  PAGINATE_PER = 10
  CALENDAR_LINE_DAYS = 14
  CALENDAR_MONTHS = 2

  def index
    @goals = current_user.goals.includes(:reports).order(:created_at).page(params[:page]).per(PAGINATE_PER)

    @calendars = @goals.map do |goal|
      Calendar.new(goal, CALENDAR_LINE_DAYS.days).generate_line
    end
  end

  def show
    @small_goals = @goal.small_goals.order(:created_at)
    @reports = @goal.reports.order(target_date: :DESC).page(params[:page])
    @calendar = Calendar.new(@goal, CALENDAR_MONTHS.months).generate_calendar
  end

  def new
    @goal = current_user.goals.new
  end

  def edit; end

  def create
    @goal = current_user.goals.new(goal_params)
    small_goals_attributes = params.dig(:goal, :small_goals_attributes)

    build_small_goals(small_goals_attributes, @goal)

    if @goal.save
      redirect_to root_path, notice: t('notice.create', content: Goal.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def update
    small_goals_attributes = params.dig(:goal, :small_goals_attributes)
    @goal.assign_attributes(goal_params)

    ActiveRecord::Base.transaction do
      destroy_small_goals(@goal, small_goals_attributes)
      update_or_create_small_goals(@goal, small_goals_attributes)
      @goal.save!
    end
    redirect_to @goal, notice: t('notice.update', content: Goal.model_name.human)
  rescue ActiveRecord::RecordInvalid => e
    move_small_goals_error(@goal, e)
    render :edit, status: :unprocessable_entity
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def destroy
    @goal.destroy
    redirect_to root_path, notice: t('notice.destroy', content: @goal.title)
  end

  private

  def set_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(%i[title start_date schedules_end_date end_date interrupted color])
  end

  def build_small_goals(small_goals_attributes, goal)
    return if small_goals_attributes.blank?

    small_goals_attributes.each_value do |small_goal_params|
      goal.small_goals.build(
        title: small_goal_params[:title],
        achievable: small_goal_params[:achievable]
      )
    end
  end

  def destroy_small_goals(goal, small_goals_attributes)
    entered_small_goals = small_goals_attributes&.values&.pluck(:id)&.map(&:to_i) || []

    goal.small_goals.where.not(id: entered_small_goals).destroy_all
  end

  def update_or_create_small_goals(goal, small_goals_attributes)
    return if small_goals_attributes.blank?

    small_goals_attributes.each_value do |small_goal_params|
      if small_goal_params.key?(:id)
        update_small_goals(goal, small_goal_params)
      else
        create_small_goals(goal, small_goal_params)
      end
    end
  end

  def create_small_goals(goal, small_goal_params)
    goal.small_goals.create!(
      title: small_goal_params[:title],
      achievable: small_goal_params[:achievable]
    )
  end

  def update_small_goals(goal, small_goal_params)
    small_goal = goal.small_goals.find(small_goal_params[:id].to_i)
    small_goal.update!(
      title: small_goal_params[:title],
      achievable: small_goal_params[:achievable]
    )
  end

  def move_small_goals_error(goal, error = nil)
    if error.record.is_a?(SmallGoal)
      goal.errors.add(:base, error.record.errors.full_messages.join)
    end
  end
end
