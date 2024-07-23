class GoalsController < ApplicationController
  def index
    @goals = Goals.order(:created_at)
  end
end
