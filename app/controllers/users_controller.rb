class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    #@user = User.find(params[:id])
  end

  def show
    # @user = User.find(params[:id])
    # debugger
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Dane zaktualizowane poprawnie!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Winer App"
      redirect_to @user
      # redirect_to user_url(@user)
      #handle a save
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "user deleted"
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #before filters
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Nie jestes zalogowany, zaloguj sie!"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Define admin privilages
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
