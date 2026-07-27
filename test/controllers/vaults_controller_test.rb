require "test_helper"

class VaultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @vault = vaults(:one)
    sign_in @user
  end

  test "should get index" do
    get vaults_url
    assert_response :success
  end

  test "should get new" do
    get new_vault_url
    assert_response :success
  end

  test "should create vault" do
    assert_difference("Vault.count", 1) do
      post vaults_url, params: { vault: { 
        login: "testlogin", 
        password: "testpass", 
        site: "Test Site", 
        url: "https://test.com" 
      } }
    end
    assert_redirected_to vaults_url
  end

  test "should get edit" do
    get edit_vault_url(@vault)
    assert_response :success
  end

  test "should update vault" do
    patch vault_url(@vault), params: { vault: { site: "Updated Site" } }
    assert_redirected_to vaults_url
  end

  test "should destroy vault" do
    assert_difference("Vault.count", -1) do
      delete vault_url(@vault)
    end
    assert_redirected_to vaults_url
  end
end