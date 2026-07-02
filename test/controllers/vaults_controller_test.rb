require "test_helper"

class VaultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vault = vaults(:one)
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
    assert_difference("Vault.count") do
      post vaults_url, params: { vault: { login: @vault.login, password: @vault.password, site: @vault.site, url: @vault.url } }
    end

    assert_redirected_to vault_url(Vault.last)
  end

  test "should show vault" do
    get vault_url(@vault)
    assert_response :success
  end

  test "should get edit" do
    get edit_vault_url(@vault)
    assert_response :success
  end

  test "should update vault" do
    patch vault_url(@vault), params: { vault: { login: @vault.login, password: @vault.password, site: @vault.site, url: @vault.url } }
    assert_redirected_to vault_url(@vault)
  end

  test "should destroy vault" do
    assert_difference("Vault.count", -1) do
      delete vault_url(@vault)
    end

    assert_redirected_to vaults_url
  end
end
