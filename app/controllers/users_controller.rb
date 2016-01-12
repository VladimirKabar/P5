class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    # @user = User.find(params[:id])
    # debugger
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
end
