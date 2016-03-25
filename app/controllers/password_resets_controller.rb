class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit

  end

  def update
    if both_password_blank?
      flash.now[:danger] = "Fields cannot be blank"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:succes] = "Password has been reset"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

  # Before filters
  def get_user
    @user= User.find_by(email: params[:email])
  end

  # Confirm a valid user
  def valid_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Returns true if password & confirmation are blank
  def both_password_blank?
    params[:user][:password].blank?
  end

  # Checks expiration of reset token
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'Password reset has expired'
      redirect_to new_password_reset_url
    end

  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end