class Admin::UsersController < ApplicationController
  before_action :set_admin_user, only: %i[ show edit update destroy ]
  before_action :admin_role_required
  # before_destroy :admin_role_validation(@admin_user)
  # GET /admin/users or /admin/users.json
  def index
    @admin_users = User.all.includes(:tasks)
  end

  # GET /admin/users/1 or /admin/users/1.json
  def show

  end

  # GET /admin/users/new
  def new
    @admin_user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users or /admin/users.json
  def create
    
    @admin_user = User.new(admin_user_params)
    if @admin_user.save
      redirect_to admin_users_path , notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity 
    end

  end

  # PATCH/PUT /admin/users/1 or /admin/users/1.json
  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to admin_users_path, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1 or /admin/users/1.json
  def destroy
    if @admin_user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    else
       redirect_to admin_users_path, notice: "requierd at least a admin"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_user_params
      params.fetch(:user, {}).permit(:email, :password, :name, :admin_role)
    end
end
