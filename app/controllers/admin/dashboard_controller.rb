class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
	layout "admin"
	
	def index
	  @super_admin_count = User.super_admin_count
	  @admin_count = User.admin_count
	  @vip_count = User.vip_count
	  @user_count = User.user_count

		@exchange_count = Exchange.count
		@coin_count = Coin.count
		@fund_count = Fund.count
		@airdrop_count = Airdrop.count

		# counts = Rails.cache.fetch('all_counts', expires_in: 1.hour) do
		# 	{
		# 		exchange_count: Exchange.count,
		# 		coin_count: Coin.count,
		# 		fund_count: Fund.count,
		# 		airdrop_count: Airdrop.count
		# 	}
		# end
	
		# @exchange_count = counts[:exchange_count]
		# @coin_count = counts[:coin_count]
		# @fund_count = counts[:fund_count]
		# @airdrop_count = counts[:airdrop_count]
	end
end
