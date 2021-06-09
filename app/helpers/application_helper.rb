module ApplicationHelper

  def logged_in?
    current_user.present?
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def choose_action_name
    if action_name == "new"
       admin_users_path
    else
       admin_user_path
    end
  end

  
end
