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

    ActiveRecord::Base.transaction do
      @goal.save!
      create_small_goals(small_goals_attributes, @goal)
    end
    redirect_to root_path, notice: t('notice.create', content: Goal.model_name.human)
  rescue ActiveRecord::RecordInvalid => e
    if e.record.is_a?(SmallGoal)
      e.record.errors.full_messages.each do |message|
        @goal.errors.add(:base, message)
      end
    end
    render :new, status: :unprocessable_entity
  end

  def update
    @small_goal = @goal.small_goals.first

    ActiveRecord::Base.transaction do
      @goal.update!(goal_params)
      @small_goal.update!(small_goal_params)

      redirect_to @goal, notice: t('notice.update', content: Report.model_name.human)
    end
  rescue ActiveRecord::RecordInvalid
    @small_goal.errors.full_messages.each do |message|
      @goal.errors.add(:base, message)
    end

    render :edit, status: :unprocessable_entity
  end

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

  def small_goal_params
    params.require(:goal).require(:small_goal).permit(:title, :achievable)
  end

  def create_small_goals(small_goals, goal)
    small_goals.each do |params|
      SmallGoal.create!(
        goal: goal,
        title: params[:title],
        achievable: params[:achievable] == '1'
      )
    end
  end

end
