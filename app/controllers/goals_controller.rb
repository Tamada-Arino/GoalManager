class GoalsController < ApplicationController
  def index
    @goals = Goal.order(:created_at)
  end
end
