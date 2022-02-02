require "application_system_test_case"

class GemsTest < ApplicationSystemTestCase
  setup do
    @gem = gems(:one)
  end

  test "visiting the index" do
    visit gems_url
    assert_selector "h1", text: "Gems"
  end

  test "should create gem" do
    visit gems_url
    click_on "New gem"

    fill_in "Authors", with: @gem.authors
    fill_in "Built at", with: @gem.built_at
    fill_in "Dependencies", with: @gem.dependencies
    fill_in "Description", with: @gem.description
    fill_in "Details", with: @gem.details
    fill_in "Licenses", with: @gem.licenses
    fill_in "Name", with: @gem.name
    fill_in "Platform", with: @gem.platform
    fill_in "Size", with: @gem.size
    fill_in "Title", with: @gem.title
    fill_in "Uid", with: @gem.uid
    fill_in "Users count", with: @gem.users_count
    fill_in "Version", with: @gem.version
    click_on "Create Gem"

    assert_text "Gem was successfully created"
    click_on "Back"
  end

  test "should update Gem" do
    visit gem_url(@gem)
    click_on "Edit this gem", match: :first

    fill_in "Authors", with: @gem.authors
    fill_in "Built at", with: @gem.built_at
    fill_in "Dependencies", with: @gem.dependencies
    fill_in "Description", with: @gem.description
    fill_in "Details", with: @gem.details
    fill_in "Licenses", with: @gem.licenses
    fill_in "Name", with: @gem.name
    fill_in "Platform", with: @gem.platform
    fill_in "Size", with: @gem.size
    fill_in "Title", with: @gem.title
    fill_in "Uid", with: @gem.uid
    fill_in "Users count", with: @gem.users_count
    fill_in "Version", with: @gem.version
    click_on "Update Gem"

    assert_text "Gem was successfully updated"
    click_on "Back"
  end

  test "should destroy Gem" do
    visit gem_url(@gem)
    click_on "Destroy this gem", match: :first

    assert_text "Gem was successfully destroyed"
  end
end
