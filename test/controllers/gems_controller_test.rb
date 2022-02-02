require "test_helper"

class GemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gem = gems(:one)
  end

  test "should get index" do
    get gems_url
    assert_response :success
  end

  test "should get new" do
    get new_gem_url
    assert_response :success
  end

  test "should create gem" do
    assert_difference("Gem.count") do
      post gems_url, params: { gem: { authors: @gem.authors, built_at: @gem.built_at, dependencies: @gem.dependencies, description: @gem.description, details: @gem.details, licenses: @gem.licenses, name: @gem.name, platform: @gem.platform, size: @gem.size, title: @gem.title, uid: @gem.uid, users_count: @gem.users_count, version: @gem.version } }
    end

    assert_redirected_to gem_url(Gem.last)
  end

  test "should show gem" do
    get gem_url(@gem)
    assert_response :success
  end

  test "should get edit" do
    get edit_gem_url(@gem)
    assert_response :success
  end

  test "should update gem" do
    patch gem_url(@gem), params: { gem: { authors: @gem.authors, built_at: @gem.built_at, dependencies: @gem.dependencies, description: @gem.description, details: @gem.details, licenses: @gem.licenses, name: @gem.name, platform: @gem.platform, size: @gem.size, title: @gem.title, uid: @gem.uid, users_count: @gem.users_count, version: @gem.version } }
    assert_redirected_to gem_url(@gem)
  end

  test "should destroy gem" do
    assert_difference("Gem.count", -1) do
      delete gem_url(@gem)
    end

    assert_redirected_to gems_url
  end
end
