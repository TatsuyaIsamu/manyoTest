class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
  include ApplicationHelper
  def login_required
    redirect_to new_session_path unless current_user
  end

  def forbid_login_user
    redirect_to tasks_path if current_user
  end 
end

