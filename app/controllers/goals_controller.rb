# frozen_string_literal: true

class GoalsController < ApplicationController
  def index
    @goals = current_user.goals.order(:created_at).page(params[:page])
  end

  def new
  end

  def create
  end
end
