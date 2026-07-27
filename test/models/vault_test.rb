# test/models/vault_test.rb
require "test_helper"

class VaultTest < ActiveSupport::TestCase
  # Setup runs before each test
  setup do
    @user = users(:one)  # Get user from fixtures
  end

  # 1. Test that a valid vault saves successfully
  test "valid vault should be saved" do
    vault = Vault.new(
      site: "Google",
      url: "https://google.com",
      login: "user@example.com",
      password: "secret123",
      user: @user
    )
    assert vault.save, "Vault with valid attributes should save"
  end

  # 2. Test that site is required
  test "vault requires a site" do
    vault = Vault.new(
      site: nil,
      url: "https://google.com",
      login: "user@example.com",
      password: "secret123",
      user: @user
    )
    assert_not vault.valid?, "Vault without site should be invalid"
    assert_includes vault.errors[:site], "can't be blank"
  end

  # 3. Test that url is required
  test "vault requires a url" do
    vault = Vault.new(
      site: "Google",
      url: nil,
      login: "user@example.com",
      password: "secret123",
      user: @user
    )
    assert_not vault.valid?, "Vault without url should be invalid"
    assert_includes vault.errors[:url], "can't be blank"
  end

  # 4. Test that login is required
  test "vault requires a login" do
    vault = Vault.new(
      site: "Google",
      url: "https://google.com",
      login: nil,
      password: "secret123",
      user: @user
    )
    assert_not vault.valid?, "Vault without login should be invalid"
    assert_includes vault.errors[:login], "can't be blank"
  end

  # 5. Test that password is required
  test "vault requires a password" do
    vault = Vault.new(
      site: "Google",
      url: "https://google.com",
      login: "user@example.com",
      password: nil,
      user: @user
    )
    assert_not vault.valid?, "Vault without password should be invalid"
    assert_includes vault.errors[:password], "can't be blank"
  end

  # 6. Test the belongs_to association
  test "vault belongs to a user" do
    vault = Vault.new(
      site: "Google",
      url: "https://google.com",
      login: "user@example.com",
      password: "secret123",
      user: @user
    )
    vault.save
    assert_equal @user, vault.user, "Vault should belong to the correct user"
  end
end