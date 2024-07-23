# frozen_string_literal: true

class GoalsController < ApplicationController
  def index
    @goals = current_user.goals.order(:created_at)
  end
end
