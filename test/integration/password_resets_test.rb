require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test "password reset" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, password_reset: {email: " " }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path, password_reset: {email: @user.email }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    user = assigns(:user)
    # Wrong email
    get edit_password_reset_path(user.reset_token, email: '') #reset_token nigdy nie bedzie ustawiony bo jest z bazy
    assert_redirected_to root_url
    # Invalid user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('token wrong', email: user.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select 'input[name=email][type=hidden][value=?]', user.email
    # Invalid password & confirmation
    patch password_reset_path(user.reset_token),
                          email: user.email,
                          user: { password:  "abcdef",
                                  password_confirmation: "kjalsoan" }
    assert_select 'div#error_explanation'
    # Blank password
    patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:  " ",
                  password_confirmation: "fffffff " }
    assert_not flash.empty?
    assert_template 'password_resets/edit'
    # Valid password & confirmation
    patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:  "foobazz",
                  password_confirmation: "foobazz" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user

  end
end