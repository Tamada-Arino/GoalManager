class ReportsController < ApplicationController
  def new
    @goal = current_user.goals.find(params[:goal_id])
    @report = @goal.reports.new
  end

  def create
  end
end
