# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    keys = %i[name avatar]
    %i[sign_up account_update].each { |action| devise_parameter_sanitizer.permit(action, keys:) }
  end
end
