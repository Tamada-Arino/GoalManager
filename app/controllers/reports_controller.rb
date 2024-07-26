# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_goal

  def new
    @report = @goal.reports.new
  end

  def edit
    @report = @goal.reports.find(params[:id])
  end

  def create
    @report = @goal.reports.new(report_params)
    if @report.save
      redirect_to @goal, notice: t('notice.create', content: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @report = @goal.reports.find(params[:id])
    if @report.update(report_params)
      redirect_to @goal, notice: t('notice.update', content: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = @goal.reports.find(params[:id])
    @report.destroy
    redirect_to @goal, notice: t('notice.destroy', content: Report.model_name.human)
  end

  private

  def set_goal
    @goal = current_user.goals.find(params[:goal_id])
  end

  def report_params
    params.require(:report).permit(%i[target_date progress_value content])
  end
end
