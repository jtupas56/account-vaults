require "application_system_test_case"

class RecordsFlowTest < ApplicationSystemTestCase
  setup do
    @user = User.create!(
      email: "capybara@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "user logs in, creates a vault, and sees it" do
    visit new_user_session_path

    fill_in "Email", with: "capybara@example.com"
    fill_in "Password", with: "password123"
    click_on "Log in"

    assert_text "Signed in successfully"

    click_on "New Vault"

    fill_in "Site", with: "Capybara Test Site"
    fill_in "Url", with: "https://capybara.test"
    fill_in "Login", with: "testuser"
    fill_in "Password", with: "supersecret"

    click_on "Create Vault"

    assert_text "Vault was successfully created"
    assert_text "Capybara Test Site"
  end
end