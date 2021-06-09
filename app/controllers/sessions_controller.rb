class SessionsController < ApplicationController

  before_action :forbid_login_user, only: %i[ new create]
  before_action :login_required, only: :destroy
 
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to user_path(@user.id)
    else 
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウト"
    redirect_to new_session_path
  end
  private
  def para_user
    params.require(:user).permit(:name, :email, :password)
  end
end
