require "test_helper"

class AirdropsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airdrop = airdrops(:one)
  end

  test "should get index" do
    get airdrops_url
    assert_response :success
  end

  test "should get new" do
    get new_airdrop_url
    assert_response :success
  end

  test "should create airdrop" do
    assert_difference("Airdrop.count") do
      post airdrops_url, params: { airdrop: { begin_time: @airdrop.begin_time, eligibility: @airdrop.eligibility, end_time: @airdrop.end_time, intro: @airdrop.intro, logo: @airdrop.logo, name: @airdrop.name, network: @airdrop.network, official_web: @airdrop.official_web, reward: @airdrop.reward, status: @airdrop.status } }
    end

    assert_redirected_to airdrop_url(Airdrop.last)
  end

  test "should show airdrop" do
    get airdrop_url(@airdrop)
    assert_response :success
  end

  test "should get edit" do
    get edit_airdrop_url(@airdrop)
    assert_response :success
  end

  test "should update airdrop" do
    patch airdrop_url(@airdrop), params: { airdrop: { begin_time: @airdrop.begin_time, eligibility: @airdrop.eligibility, end_time: @airdrop.end_time, intro: @airdrop.intro, logo: @airdrop.logo, name: @airdrop.name, network: @airdrop.network, official_web: @airdrop.official_web, reward: @airdrop.reward, status: @airdrop.status } }
    assert_redirected_to airdrop_url(@airdrop)
  end

  test "should destroy airdrop" do
    assert_difference("Airdrop.count", -1) do
      delete airdrop_url(@airdrop)
    end

    assert_redirected_to airdrops_url
  end
end
