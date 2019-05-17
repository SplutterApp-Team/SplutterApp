require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", 
      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" *244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation shoul reject valid addresses" do
    valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn) 
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{ valid_address.inspect } should be valid"
    end
  end

  test "email validation shoul reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com foo@bar..com] 
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? shoukd return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Text")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    example = users(:example)
    haker = users(:haker)
    assert_not example.following?(haker)
    example.follow(haker)
    assert example.following?(haker)
    assert haker.followers.include?(example)
    example.unfollow(haker)
    assert_not example.following?(haker)
  end

  test "feed should have the right posts" do
    example = users(:example)
    haker = users(:haker)
    lana =users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert example.feed.include?(post_following)
    end
    # Posts from self
    example.microposts.each do |post_self|
      assert example.feed.include?(post_self)
    end
    # Posts from unfollowed user
    haker.microposts.each do |post_unfollowed|
      assert_not example.feed.include?(post_unfollowed)
    end
  end
end
