# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update]

  def index
    @goals = current_user.goals.order(:created_at).page(params[:page])
  end

  def show; end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to root_path, notice: t('notice.create', content: Goal.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: t('notice.update', content: Goal.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(%i[title start_date schedules_end_date end_date interrupted color])
  end
end
