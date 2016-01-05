require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "test", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should be name present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "should be email present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "jjj" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "jjj" * 255
    assert_not @user.valid?
  end

  test "email validation should accept valid adresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.ba.org
                      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid|
      @user.email = valid
      assert @user.valid?, "Address #{valid.inspect} should be valid"
    end
  end

  test "email validation should reject invalid adresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com
                        foo@ba+baz.com]
    invalid_addresses.each do |invalid|
      @user.email = invalid
      assert_not @user.valid?, "Address #{invalid.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase

    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have min lenght" do
    @user.password = @user.password_confirmation = "a" *5
    assert_not @user.valid?
  end
end
