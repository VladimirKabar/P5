require 'test_helper'

class UsersSignUpTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do

      post users_path, user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"}

    end
    # before_count = User.count
    # post users_path, user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" }
    # after_count = User.count
    # assert_equal before_count, after_count
    assert_template 'users/new'

  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do

      post_via_redirect users_path, user: {name: "Example", email: "example@invalid.com", password: "foobar", password_confirmation: "foobar"}

    end
    assert_template 'users/show'

  end
end
