class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
  include ApplicationHelper

  def login_required
    redirect_to new_session_path unless current_user
  end

  def forbid_login_user
    redirect_to tasks_path if current_user
  end 

  def forbid_other_user(user)
    if current_user != user
      redirect_to tasks_path, notice: "権限がありません"
    end
  end

  def admin_role_required
    if logged_in?
      unless current_user.admin_role
      redirect_to new_session_path, notice: "権限がありません" 
      end
    else
      redirect_to new_session_path, notice:"権限がありません"
    end
  end
end

