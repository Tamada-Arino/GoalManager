# frozen_string_literal: true

class ReportsController < ApplicationController
  def new
    @goal = current_user.goals.find(params[:goal_id])
    @report = @goal.reports.new
  end

  def create
    @goal = current_user.goals.find(params[:goal_id])
    @report = @goal.reports.new(report_params)
    if @report.save
      redirect_to @goal, notice: t('notice.create', content: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @goal = current_user.goals.find(params[:goal_id])
    @report = @goal.reports.find(params[:id])
  end

  def update
  end

  private

  def report_params
    params.require(:report).permit(%i[target_date progress_value content])
  end
end
