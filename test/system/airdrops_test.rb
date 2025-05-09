require "application_system_test_case"

class AirdropsTest < ApplicationSystemTestCase
  setup do
    @airdrop = airdrops(:one)
  end

  test "visiting the index" do
    visit airdrops_url
    assert_selector "h1", text: "Airdrops"
  end

  test "should create airdrop" do
    visit airdrops_url
    click_on "New airdrop"

    fill_in "Begin time", with: @airdrop.begin_time
    fill_in "Eligibility", with: @airdrop.eligibility
    fill_in "End time", with: @airdrop.end_time
    fill_in "Intro", with: @airdrop.intro
    fill_in "Logo", with: @airdrop.logo
    fill_in "Name", with: @airdrop.name
    fill_in "Network", with: @airdrop.network
    fill_in "Official web", with: @airdrop.official_web
    fill_in "Reward", with: @airdrop.reward
    fill_in "Status", with: @airdrop.status
    click_on "Create Airdrop"

    assert_text "Airdrop was successfully created"
    click_on "Back"
  end

  test "should update Airdrop" do
    visit airdrop_url(@airdrop)
    click_on "Edit this airdrop", match: :first

    fill_in "Begin time", with: @airdrop.begin_time.to_s
    fill_in "Eligibility", with: @airdrop.eligibility
    fill_in "End time", with: @airdrop.end_time.to_s
    fill_in "Intro", with: @airdrop.intro
    fill_in "Logo", with: @airdrop.logo
    fill_in "Name", with: @airdrop.name
    fill_in "Network", with: @airdrop.network
    fill_in "Official web", with: @airdrop.official_web
    fill_in "Reward", with: @airdrop.reward
    fill_in "Status", with: @airdrop.status
    click_on "Update Airdrop"

    assert_text "Airdrop was successfully updated"
    click_on "Back"
  end

  test "should destroy Airdrop" do
    visit airdrop_url(@airdrop)
    click_on "Destroy this airdrop", match: :first

    assert_text "Airdrop was successfully destroyed"
  end
end
