# frozen_string_literal: true

class GoalsController < ApplicationController
  def index
    @goals = current_user.goals.order(:created_at).page(params[:page])
  end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to root_path, notice: '目標を作成しました！'
    else
      render :new
    end
  end

  private

  def goal_params
    params.require(:goal).permit(%i[title start_date schedules_end_date end_date interrupted])
  end
end
