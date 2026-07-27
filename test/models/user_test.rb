# test/models/user_test.rb
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # 1. Test that a valid user saves successfully
  test "valid user should be saved" do
    user = User.new(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    assert user.save, "User with valid attributes should save"
  end

  # 2. Test that email is required
  test "user requires an email" do
    user = User.new(
      email: nil,
      password: "password123",
      password_confirmation: "password123"
    )
    assert_not user.valid?, "User without email should be invalid"
    assert_includes user.errors[:email], "can't be blank"
  end

  # 3. Test that email must be unique
  test "user requires a unique email" do
    existing_user = users(:one)  # From fixtures

    user = User.new(
      email: existing_user.email,
      password: "password123",
      password_confirmation: "password123"
    )
    assert_not user.valid?, "User with duplicate email should be invalid"
    assert_includes user.errors[:email], "has already been taken"
  end

  # 4. Test that password is required
  test "user requires a password" do
    user = User.new(
      email: "test@example.com",
      password: nil,
      password_confirmation: nil
    )
    assert_not user.valid?, "User without password should be invalid"
    assert_includes user.errors[:password], "can't be blank"
  end

  # 5. Test password minimum length (Devise default is 6)
  test "user password must be at least 6 characters" do
    user = User.new(
      email: "test@example.com",
      password: "12345",
      password_confirmation: "12345"
    )
    assert_not user.valid?, "User with short password should be invalid"
    assert_includes user.errors[:password], "is too short (minimum is 6 characters)"
  end

  # 6. Test that user has many vaults
  test "user has many vaults" do
    user = users(:one)
    vault = vaults(:one)
    
    assert_equal user.vaults, [vault], "User should have associated vaults"
  end

  # 7. Test that destroying user destroys their vaults (dependent: :destroy)
  test "destroying user destroys their vaults" do
    user = users(:one)
    vault = vaults(:one)
    
    assert_difference("Vault.count", -1) do
      user.destroy
    end
  end
end